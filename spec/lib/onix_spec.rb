require "./spec/spec_helper"

def load_onix_product(*file_path)
  file_path[-1] += ".xml"
  MetadataParser::PublisherTools::Row::Onix.new(load_fixture_file(*file_path).read, PublisherToolsConfig.new)
end

def load_onix_product_component(*file_path)
  o = load_onix_product(*file_path)
  o.product_component
end

describe ::MetadataParser::PublisherTools::Row::Onix do
  it "accepts a product xml fragment and produces a parsed version of that data" do
    o = load_onix_product("good", "one_dated_price")
    o.isbn.should == "9780544034792"
    o.full_title.should == "Infatuate: A Gilded Wings Novel, Book Two"
    o.description.should == "Cool Description, Bro"
    o.prices.count.should == 1
    price = o.prices.first

    price.retail_price.should == BigDecimal.new("16.99")
    price.valid_from.should == Date.parse("20130209")
    price.valid_until.should be_nil
    price.countries.should == ["US"]
    price.currency.should == "USD"
    price.pricing_model.should == "Wholesale"

    o.publish_date.should == Date.parse("20130305")
    o.deleting.should be_false
  end

  it "returns nil for those attributes that are spreadsheet-only" do
    o = load_onix_product("good", "one_dated_price")
    o.currency_code.should be_nil
    o.for_subscription.should be_nil
    o.for_direct_purchase.should be_nil
    o.page_restriction_type.should be_nil
    o.page_restriction_value.should be_nil
    o.buy_url.should be_nil
    o.category.should be_nil
    o.tags.should be_nil
    o.download_and_drm.should be_nil
    o.flex_columns.should be_nil
    o.flex_schema.should be_nil
    o.collections.should be_nil
    o.featured_collection.should be_nil
    o.list_price.should be_nil
  end

  describe "#publish_date" do
    it "parses out sale date when different from publish date" do
      o = load_onix_product('good', 'sale_and_published_dates')
      o.publish_date.should == Date.parse('20130725')
    end
  end

  describe "#YearFirstPublished" do
    it "parses YearFirstPublished field" do
      o = load_onix_product_component('good', 'sale_and_published_dates')
      o.year_first_published.should == '1776'
    end
  end

  describe '#prices' do
   context 'given one undated price' do
     it 'can load an undated price' do
       o = nil
       price = nil
       Timecop.freeze do
         o = load_onix_product 'good', 'one_undated_price'
         price = o.prices.first
       end

       price.valid_from.should be_nil
       price.valid_until.should be_nil

       o.should be_valid
       o.errors[:prices].should be_empty
     end
   end

   context 'given one dated price' do
     it 'sets that dated price' do
       o = load_onix_product 'good', 'one_dated_price'
       o.prices.first.retail_price.should == BigDecimal.new('16.99')
       o.prices.first.price_qualifier.should == '05'
       o.prices.first.has_us_retail_price?.should == true
     end
   end

   context 'given multiple dated prices' do
    it 'sets those dated prices good.  real good.' do
      o = load_onix_product 'good', 'multiple_dated_prices'
      o.prices.count.should == 2

      o.prices.first.valid_from.should == Date.parse("20130209")
      o.prices.first.retail_price.should == BigDecimal.new("16.99")

      o.prices.last.valid_from.should == Date.parse("20170209")
      o.prices.last.retail_price.should == BigDecimal.new("17.99")
    end
  end

  context 'given prices with restrictions' do
    it 'Sets excluded countries. In the face.' do
      o = load_onix_product 'good', 'dated_prices_with_exclusions'
      o.prices.count.should == 2
      excluded_price = nil
      non_excluded_price = nil
      o.prices.each do |price|
        if price.excluded_countries.present?
          excluded_price = price
        else
          non_excluded_price = price
        end
      end
      excluded_price.should be_present
      non_excluded_price.should be_present

      excluded_price.excluded_countries.should == "US"
      excluded_price.countries.should be_blank
      non_excluded_price.countries.should == ["US"]
    end
  end
end

context "Geo Restrictions" do
  it 'puts the loti...reads the restrictions' do
    o = load_onix_product 'good', 'multiple_dated_prices'
    o.sales_rights.count.should == 3
    rights = o.sales_rights
    rights[0].allowed?.should == true
    rights[0].countries.should == ["US", "CA"]
    rights[1].allowed?.should == false
    rights[1].banned?.should == true
    rights[1].countries.should == ["VI", "NZ"]
    rights[2].allowed?.should == true
    rights[2].countries.should == ['world']
  end

  it 'returns errors when given bad data' do
    o = load_onix_product 'evil', 'bad_geo_restrictions'
    o.sales_rights
    o.errors.should_not be_blank
  end
end

context "Authors" do
  it 'Creates authors from onix files. Or out of thin air.' do
    o = load_onix_product 'good', 'multiple_dated_prices'
    authors = o.authors
    authors.count.should == 2
    author = authors.first

    author.name.should == "Aimee Agresti"
    author.sequence.should == 1
    author.description.should == "Hello There!"
    author.is_author?.should be_true
  end
  it "Properly handles non-ascii characters" do
    o = load_onix_product 'good', 'author_with_unicode'
    author = o.authors.first
    author.name.should == "Javier GarcíaMartínez"
  end
end

context "Imprints" do
  it "creates imprints from onix files" do
    o = load_onix_product 'good', 'one_dated_price'
    imprint1, imprint2 = o.imprints
    imprint1.name.should == "Harcourt Children's Books"
    imprint2.name.should == "Houghton Mifflin Harcourt"
  end
end

context "Bisac Categories" do
  it 'Creates bisac categories from an onix file' do
    o = load_onix_product 'good', 'multiple_dated_prices'
    categories = o.bisac_categories
    categories.count.should == 11
    cat = categories
      #order is unimportant, so let's sort them in a consistent manner here.
      cat.sort.should == ["JUV014000", "JUV017080", "JUV021000", "JUV023000", "JUV026000", "JUV028000", "JUV039060", "JUV039140", "JUV039220", "JUV046000", "JUV058000"]
    end
  end

  describe "#pages" do
    it "sets page count" do
      o = load_onix_product 'good', 'pagecount_pubdate_language_title_subtitle'
      o.page_count.should == "493"
    end
  end

  describe "#pages composite" do
    it "sets page count" do
      o = load_onix_product 'good', 'composite_pagecount_pubdate_language_title_subtitle'
      o.page_count.should == "394"
    end
  end

  describe "#publication date" do
    it "parses the publication date" do
      o = load_onix_product_component 'good', 'composite_pagecount_pubdate_language_title_subtitle'
      o.publication_date.should == "1987"
    end
  end

  describe "#language" do
    it "sets the language" do
      o = load_onix_product 'good', 'pagecount_pubdate_language_title_subtitle'
      o.language.should == "eng"
    end
  end

  describe "#language composite" do
    it "sets the language" do
      o = load_onix_product 'good', 'composite_pagecount_pubdate_language_title_subtitle'
      o.language.should == "eng"
    end
  end

  describe "#title and subtitle" do
    it "sets the title" do
      o = load_onix_product 'good', 'pagecount_pubdate_language_title_subtitle'
      o.title.should == "British English, A to Zed"
    end

    it "sets the subtitle" do
      o = load_onix_product 'good', 'pagecount_pubdate_language_title_subtitle'
      o.subtitle.should == "cats everywhere..."
    end

    it "sets the full_title" do
      o = load_onix_product 'good', 'pagecount_pubdate_language_title_subtitle'
      o.full_title.should == "British English, A to Zed: cats everywhere..."
    end
  end

  describe "#title composite" do
    it "sets the title" do
      o = load_onix_product 'good', 'composite_pagecount_pubdate_language_title_subtitle'
      o.title.should == "Cats with Thumbs"
    end

    it "sets the subtitle" do
      o = load_onix_product 'good', 'composite_pagecount_pubdate_language_title_subtitle'
      o.subtitle.should == "the impending catastrophy"
    end

    it "sets the full_title" do
      o = load_onix_product 'good', 'composite_pagecount_pubdate_language_title_subtitle'
      o.full_title.should == "Cats with Thumbs: the impending catastrophy"
    end
  end

  describe "#audience" do
    before(:all) do
      @o = load_onix_product("good", "audience_range_composite")
      @product = @o.product_component
    end

    it "parses audience range qualifier" do
      audience_range = @product.audience_range
      audience_range[0].range_code.should == '11'
    end

    it "parses audience range precisions/value fields" do
      audience_range = @product.audience_range
      audience_range[0].range_precision.should == ["03", "04"]
      audience_range[0].range_value.should == ["5", "10"]
    end

    it "generates audience range" do
      audience = @o.audience

      audience.age_low.should == 10
      audience.age_high.should == 15
    end

    it "converts an audience code into an age range" do
      audience = MetadataParser::PublisherTools::Component::Onix::Audience.new

      audience.set_range_from_codes(['02'])

      audience.age_low.should == 3
      audience.age_high.should == 17
    end

    it "converts multiple audience codes into an age range" do
      audience = MetadataParser::PublisherTools::Component::Onix::Audience.new

      audience.set_range_from_codes(['02', '05'])

      audience.age_low.should == 3
      audience.age_high.should == 25
    end

    it "converts grade ranges into age range" do
      audience = MetadataParser::PublisherTools::Component::Onix::Audience.new

      audience.set_range_from_grades(['P', '5'])
      audience.age_low.should == 4
      audience.age_high.should == 10

      audience.set_range_from_grades(['9'])
      audience.age_low.should == 14
      audience.age_high.should == 14  # returning nil
    end
  end

  describe "Isbns" do
    #This is effectively an integration test.
    # It tests that we:
    # Pull in the proper isbn identifiers (related products, product identifier, work identifier, default isbn)
    # That we don't pull in invalid related product types(132, with isbn 97808108)
    # That we don't pull in invalid product id types (153, isbn 1999999).
    it "pulls in all related isbns" do
      o = load_onix_product("good", "multiple_isbns")
      o.alternate_isbns.sort.should == ["9780810891982", "9780810891975", "91992304333", "work_isbn"].sort
    end
    it "properly handles no related isbns" do
      o = load_onix_product("good", "audience_range_composite")
      o.alternate_isbns.should == ["0816016356"]
    end
    it "properly handles value type 24" do
      o = load_onix_product("good", "isbn24")
      o.alternate_isbns.sort.should == ["9781118046322", "9781118046388"].sort
      o.isbn.should == "9781118046388"
    end
  end

  describe "#deleting" do
    before(:all) do
      @o = load_onix_product("good", "one_dated_price")
      @product = @o.product_component
    end

    context "given a deleting status" do
      it 'is true' do
        RSpec::Mocks.proxy_for(@o).reset
        @o.deleting.should be_false
        @product.stub(:publishing_status => 3)
        @o.deleting.should be_true
      end
      context 'given a deleting availability' do
        it 'is true' do
          RSpec::Mocks.proxy_for(@o).reset
          @o.deleting.should be_false
          @product.stub(:availability_code => "AB")
          @o.deleting.should be_true
        end
      end

      context 'given a deleting code' do
        it 'is true' do
          RSpec::Mocks.proxy_for(@o).reset
          @o.deleting.should be_false
          @product.stub(:product_availability => 34)
          @o.deleting.should be_true
        end
      end

      context 'given a forthcoming doc' do
        before(:each) do
          RSpec::Mocks.proxy_for(@o).reset
          @o.deleting.should be_false
          @product.stub(:forthcoming => true)
        end

        context 'and no publication date' do
          it 'is true' do
            @product.stub(:publish_date => false)
            @o.stub(:publish_date => false)
            @o.deleting.should be_true
          end
        end

        context 'and a publication date' do
          it 'is false' do
            @o.deleting.should be_false
          end
        end
      end
    end
  end

  describe "Series" do
    # TODO: create fixtures with these fields
    before(:all) do
      @product = load_onix_product('good', 'series_identifier_composite')
    end

    it "parses the issn" do
      # PR.5.1
      # TODO: do we care about this field?
    end

    it "parses the series title" do
      # PR.5.6
      @product.series.first.title.should == 'Throne of Cats'
    end

    it "parses the number within series" do
      # PR.5.7
      @product.series.first.position_entity.should == 'Volume 10'
    end

    it "parses the position from the number within series" do
      @product.series.first.position.should == 10
    end

    context 'series identifier composite' do
      it "parses the series identifier type code" do
        # PR.5.3
        @product.series.first.series_identifier.first.type_code.should == 1
      end

      it "parses the series identifier value" do
        # PR.5.5
        @product.series.first.series_identifier.first.value.should == '1234-5678'
      end

      it "returns all identifiers" do
        @product.series[0].identifiers[0].type_code.should == 1
        @product.series[0].identifiers[0].value.should == '1234-5678'
        @product.series[0].identifiers[1].type_code.should == 4
        @product.series[0].identifiers[1].value.should == '89.123'
        @product.series[1].identifiers[0].type_code.should == 2
        @product.series[1].identifiers[0].value.should == '1234'
      end

    end
  end
end
