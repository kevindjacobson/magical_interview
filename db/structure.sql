CREATE TABLE `access_blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` int(10) unsigned NOT NULL DEFAULT '0',
  `word_user_id` int(11) NOT NULL DEFAULT '0',
  `block_type` tinyint(4) NOT NULL DEFAULT '0',
  `block_reason` tinyint(4) NOT NULL DEFAULT '0',
  `permanent` tinyint(1) NOT NULL DEFAULT '1',
  `block_start` datetime DEFAULT NULL,
  `block_end` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ip_address_block_type` (`ip_address`,`block_type`),
  KEY `idx_user_block_type` (`word_user_id`,`block_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `administrative_document_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `nastygram_type` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `detail` varchar(2048) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_admin_doc_actions_on_word_document_id_and_created_at` (`word_document_id`,`created_at`),
  KEY `index_administrative_document_actions_on_reason` (`reason`),
  KEY `index_administrative_document_actions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `administrative_user_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `nastygram_type` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `detail` varchar(2048) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `admin_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_administrative_user_actions_on_word_user_id_and_created_at` (`word_user_id`,`created_at`),
  KEY `index_administrative_user_actions_on_reason` (`reason`),
  KEY `index_administrative_user_actions_on_updated_at` (`updated_at`),
  KEY `index_administrative_user_actions_on_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` varchar(255) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_announcements_on_created_at` (`created_at`),
  KEY `index_announcements_on_identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `announcements_word_documents` (
  `announcement_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  UNIQUE KEY `announcement_and_document` (`announcement_id`,`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `anonymous_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `generating_browser_uuid` varchar(36) NOT NULL,
  `generation_reason` varchar(255) NOT NULL,
  `ip_address` int(10) unsigned NOT NULL,
  `current_status` varchar(30) NOT NULL,
  `status_changed_at` datetime DEFAULT NULL,
  `status_changed_from` varchar(30) DEFAULT NULL,
  `merged_into_word_user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_anonymous_users_on_word_user_id` (`word_user_id`),
  KEY `index_anonymous_users_on_generating_browser_uuid` (`generating_browser_uuid`),
  KEY `index_anonymous_users_on_ip_address` (`ip_address`),
  KEY `index_anonymous_users_on_current_status` (`current_status`),
  KEY `index_anonymous_users_on_status_changed_from` (`status_changed_from`),
  KEY `index_anonymous_users_on_merged_into_word_user_id` (`merged_into_word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `api_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `account_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `api_key` varchar(30) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `api_secret` varchar(30) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `publisher_key` varchar(30) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `explanation` text,
  `websites_text` text,
  `tos_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `require_signing` tinyint(1) NOT NULL DEFAULT '0',
  `unlimited_uploads` tinyint(1) NOT NULL DEFAULT '0',
  `upload_limit_email_status` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`),
  UNIQUE KEY `idx_api_key` (`api_key`),
  UNIQUE KEY `idx_publisher_key` (`publisher_key`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `api_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_account_id` int(11) DEFAULT '0',
  `word_user_id` int(11) DEFAULT '0',
  `session_key` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `expired` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_api_sessions_on_session_key` (`session_key`),
  KEY `index_api_sessions_on_word_user_id_and_api_account_id` (`word_user_id`,`api_account_id`),
  KEY `index_api_sessions_on_api_account_id` (`api_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `audiobook_chapters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `audiobook_id` int(11) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `part_number` int(11) NOT NULL DEFAULT '0',
  `chapter_number` int(11) NOT NULL DEFAULT '0',
  `runtime` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_audiobook_version_part_number_chapter_number` (`audiobook_id`,`version`,`part_number`,`chapter_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `audiobooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `actual_size` bigint(20) unsigned NOT NULL,
  `runtime` bigint(20) unsigned NOT NULL,
  `chapterized` tinyint(1) NOT NULL,
  `abridged` tinyint(1) NOT NULL,
  `parts_count` int(10) unsigned NOT NULL,
  `chapters_count` int(10) unsigned NOT NULL,
  `external_id` varchar(255) NOT NULL,
  `chapters_version` int(11) NOT NULL DEFAULT '0',
  `chapters_signature` tinyblob NOT NULL,
  `metadata_signature` varchar(255) DEFAULT NULL,
  `original_publisher` varchar(255) DEFAULT NULL,
  `list_price` decimal(5,2) unsigned DEFAULT NULL,
  `invoice_cost` decimal(5,2) unsigned DEFAULT NULL,
  `cover_url` varchar(255) DEFAULT NULL,
  `sample_url` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `external_product_id` varchar(255) DEFAULT NULL,
  `for_sale` tinyint(1) NOT NULL DEFAULT '0',
  `payout_threshold_ms` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  UNIQUE KEY `idx_user_external` (`word_user_id`,`external_id`),
  UNIQUE KEY `idx_user_product_id` (`word_user_id`,`external_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `author_category_popularities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  `popularity` float NOT NULL DEFAULT '0',
  `format_type` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_category_format_type` (`word_user_id`,`category_id`,`format_type`),
  KEY `idx_category_format_type_popularity` (`category_id`,`format_type`,`popularity`),
  KEY `idx_category_popularity` (`category_id`,`popularity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `author_global_popularities` (
  `word_user_id` int(11) NOT NULL,
  `popularity` float NOT NULL,
  PRIMARY KEY (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `author_global_staging_popularities` (
  `word_user_id` int(11) NOT NULL,
  `popularity` float NOT NULL,
  PRIMARY KEY (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `authored_languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `language_id` smallint(6) NOT NULL DEFAULT '1',
  `docs_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_language` (`word_user_id`,`language_id`),
  KEY `idx_language_docs_count` (`language_id`,`docs_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `publisher_user_id` int(11) NOT NULL,
  `data_source_key` int(11) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `author_name_crc32` int(10) unsigned NOT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `external_id_crc32` int(10) unsigned NOT NULL DEFAULT '0',
  `bowker_id` int(11) DEFAULT NULL,
  `author_last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_publisher_user_external` (`publisher_user_id`,`external_id`),
  KEY `idx_publisher_user` (`publisher_user_id`),
  KEY `idx_data_source_key` (`data_source_key`),
  KEY `idx_publisher_user_author_name_crc32` (`publisher_user_id`,`author_name_crc32`),
  KEY `idx_bowker` (`bowker_id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_publisher_user_external_id_crc32` (`publisher_user_id`,`external_id_crc32`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `authorships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `sequence_number` int(11) NOT NULL,
  `data_source_key` int(11) NOT NULL,
  `contribution_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_user_contribution_type` (`word_document_id`,`word_user_id`,`contribution_type`),
  KEY `idx_user_sequence_number` (`word_user_id`,`sequence_number`),
  KEY `idx_data_source_key` (`data_source_key`),
  KEY `idx_document_contribution_type` (`word_document_id`,`contribution_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `bisac_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(25) CHARACTER SET latin1 DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`),
  KEY `idx_parent` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `bisac_category_mapping_intersection_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bisac_category_mapping_intersection_id` int(11) NOT NULL,
  `bisac_category_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bisac_category_mapping_intersection_bisac_category` (`bisac_category_mapping_intersection_id`,`bisac_category_id`),
  KEY `idx_bisac_category` (`bisac_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `bisac_category_mapping_intersections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `bisac_category_mappings` (
  `bisac_category_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  UNIQUE KEY `idx_bisac_category_category` (`bisac_category_id`,`category_id`),
  KEY `idx_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `bisac_category_memberships` (
  `bisac_category_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  UNIQUE KEY `idx_document_bisac_category` (`word_document_id`,`bisac_category_id`),
  KEY `idx_bisac_category` (`bisac_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `blocks` (
  `blocker_id` int(11) NOT NULL,
  `victim_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_blocks_on_blocker_id_and_victim_id` (`blocker_id`,`victim_id`),
  KEY `index_blocks_on_victim_id` (`victim_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `book_global_popularities` (
  `word_document_id` int(11) NOT NULL,
  `popularity` float NOT NULL,
  `librarything_score` float DEFAULT NULL,
  PRIMARY KEY (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `book_global_staging_popularities` (
  `word_document_id` int(11) NOT NULL,
  `popularity` float NOT NULL,
  `librarything_score` float DEFAULT NULL,
  PRIMARY KEY (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `book_metadata_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `book_metadata_type_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name_book_metadata_type` (`name`,`book_metadata_type_id`),
  KEY `idx_book_metadata_type` (`book_metadata_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `book_metadata_attributes_external_tags` (
  `external_tag_id` int(11) NOT NULL,
  `book_metadata_attribute_id` int(11) NOT NULL,
  UNIQUE KEY `idx_book_metadata_attribute_external_tag` (`book_metadata_attribute_id`,`external_tag_id`),
  KEY `idx_external_tag` (`external_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `book_metadata_attributes_magic_collections` (
  `book_metadata_attribute_id` int(11) NOT NULL,
  `magic_collection_id` int(11) NOT NULL,
  UNIQUE KEY `idx_book_metadata_attribute_magic_collection` (`book_metadata_attribute_id`,`magic_collection_id`),
  KEY `idx_magic_collection` (`magic_collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `book_metadata_attributes_word_document_approvals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) DEFAULT NULL,
  `book_metadata_attribute_id` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `intensity` tinyint(4) NOT NULL DEFAULT '0',
  `editorial_word_user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_book_metadata_attribute_document` (`book_metadata_attribute_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_book_metadata_attribute_intensity` (`book_metadata_attribute_id`,`intensity`),
  KEY `idx_document_intensity_book_metadata_attribute` (`word_document_id`,`intensity`,`book_metadata_attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `book_metadata_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `secondary_subtitle` varchar(64) DEFAULT NULL,
  `language_id` smallint(6) NOT NULL DEFAULT '2',
  `page_count` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `age_low` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `age_high` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `publication_year` smallint(6) NOT NULL DEFAULT '0',
  `publication_month` tinyint(4) NOT NULL DEFAULT '0',
  `publication_day` tinyint(4) NOT NULL DEFAULT '0',
  `publisher_publication_year` smallint(6) NOT NULL DEFAULT '0',
  `publisher_publication_month` tinyint(4) NOT NULL DEFAULT '0',
  `publisher_publication_day` tinyint(4) NOT NULL DEFAULT '0',
  `publication_date_source` tinyint(4) NOT NULL DEFAULT '0',
  `audience_restricted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `brandings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_picture_url` varchar(255) DEFAULT NULL,
  `custom_logo_image_url` varchar(255) DEFAULT NULL,
  `custom_logo_click_url` varchar(255) DEFAULT NULL,
  `promo_picture_url` varchar(255) DEFAULT NULL,
  `default_image_exists` tinyint(1) NOT NULL DEFAULT '0',
  `banner_image_exists` tinyint(1) NOT NULL DEFAULT '0',
  `promo_image_exists` tinyint(1) NOT NULL DEFAULT '0',
  `banner_bg_image_exists` tinyint(1) NOT NULL DEFAULT '0',
  `custom_logo_image_exists` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `cache_revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cur_value` bigint(20) NOT NULL,
  `prev_value` bigint(20) NOT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  `purge_start` datetime NOT NULL,
  `purge_end` datetime NOT NULL,
  `previous_id` int(11) DEFAULT NULL,
  `user` varchar(255) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cache_revisions_on_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `display_order` int(11) DEFAULT '0',
  `long_name` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `standalone_name` varchar(255) DEFAULT NULL,
  `noun_form` varchar(255) DEFAULT NULL,
  `in_store` smallint(6) DEFAULT '0',
  `visible_only` tinyint(4) DEFAULT NULL,
  `default_document_length` int(11) NOT NULL DEFAULT '2',
  `in_presentation` tinyint(1) DEFAULT NULL,
  `in_spreadsheet` tinyint(1) DEFAULT NULL,
  `force_grid_layout` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `content_type_flags` int(10) unsigned NOT NULL DEFAULT '0',
  `category_ancestors_count` int(11) DEFAULT '0',
  `included_text_razor_content_types_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `hidden_from_search` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_categories_on_name` (`name`),
  KEY `index_categories_on_slug` (`slug`),
  KEY `parent_search_name` (`parent_id`,`name`),
  KEY `index_categories_on_in_store` (`in_store`),
  KEY `categories_display_list` (`visible_only`,`display_order`),
  KEY `idx_parent_slug` (`parent_id`,`slug`),
  KEY `idx_id_visible_only_hidden_from_search` (`id`,`visible_only`,`hidden_from_search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `category_aliases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_category_id` int(11) NOT NULL,
  `alias_category_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias_category_parent_category` (`alias_category_id`,`parent_category_id`),
  KEY `idx_parent_category` (`parent_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `category_ancestors` (
  `category_id` int(11) NOT NULL,
  `ancestor_id` int(11) NOT NULL,
  `depth` tinyint(4) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_category_ancestor` (`category_id`,`ancestor_id`),
  KEY `idx_ancestor` (`ancestor_id`),
  KEY `idx_depth_category` (`depth`,`category_id`),
  KEY `idx_ancestor_depth` (`ancestor_id`,`depth`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `category_group_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `category_group_id` int(11) NOT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `filter_format_types` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_category_group` (`category_id`,`category_group_id`),
  UNIQUE KEY `idx_category_group_position` (`category_group_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `category_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `audiobook_name` varchar(255) DEFAULT NULL,
  `parent_category_id` int(11) NOT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_parent_category_name` (`parent_category_id`,`name`),
  UNIQUE KEY `idx_parent_category_position` (`parent_category_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `category_list_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` int(11) NOT NULL,
  `category_list_id` int(11) NOT NULL,
  `category_list_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_list_category_list_item` (`category_list_id`,`category_list_item_id`),
  UNIQUE KEY `idx_category_list_position` (`category_list_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `category_memberships` (
  `category_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  UNIQUE KEY `idx_category_document` (`category_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_category_created` (`category_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `classified_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `word_document_id` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `cms_blocked_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cms_blocked_accounts_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `collection_group_document_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collection_group_id` int(11) NOT NULL,
  `document_collection_id` int(11) NOT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_collection_collection_group` (`document_collection_id`,`collection_group_id`),
  KEY `idx_collection_group_position` (`collection_group_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `collection_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `collection_group_document_collections_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `comic_issues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `issue_number` int(11) NOT NULL,
  `original_release_date` date DEFAULT NULL,
  `comic_series_id` int(11) DEFAULT NULL,
  `comic_volume_id` int(11) DEFAULT NULL,
  `comic_type` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_comic_series` (`comic_series_id`),
  KEY `idx_comic_volume_issue_number` (`comic_volume_id`,`issue_number`),
  KEY `idx_comic_type` (`comic_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `comic_series` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_collection_id` int(11) NOT NULL,
  `publisher_tools_config_id` int(11) NOT NULL,
  `series_name` varchar(255) NOT NULL,
  `year_began` smallint(6) DEFAULT NULL,
  `year_ended` smallint(6) DEFAULT NULL,
  `num_issues_in_series` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_collection` (`document_collection_id`),
  UNIQUE KEY `idx_series_name_publisher_tools_config` (`series_name`,`publisher_tools_config_id`),
  KEY `idx_publisher_tools_config` (`publisher_tools_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `comic_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `first_issue_number` int(11) DEFAULT NULL,
  `last_issue_number` int(11) DEFAULT NULL,
  `volume_number` int(11) NOT NULL,
  `comic_series_id` int(11) DEFAULT NULL,
  `comic_type` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_comic_series_volume_number` (`comic_series_id`,`volume_number`),
  KEY `idx_comic_type` (`comic_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `community_exclusions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_community_exclusions_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `content_pool_admin_overrides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_pool_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_type` tinyint(3) unsigned NOT NULL,
  `action` tinyint(3) unsigned NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_type_item_content_pool` (`item_type`,`item_id`,`content_pool_id`),
  KEY `idx_admin_user` (`admin_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `content_pool_document_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_pool_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_content_pool` (`word_document_id`,`content_pool_id`),
  KEY `idx_content_pool` (`content_pool_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `content_pool_user_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_pool_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_content_pool` (`word_user_id`,`content_pool_id`),
  KEY `idx_content_pool` (`content_pool_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `content_pools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`),
  KEY `idx_admin_user_name` (`admin_user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `controlled_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `disable_related_docs` tinyint(1) DEFAULT NULL,
  `max_applications_per_day` int(11) DEFAULT NULL,
  `max_devices_stored_on` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_controlled_documents_on_word_document_id` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `copyright_excluded_authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `copyright_filter_matches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_document_id` int(11) NOT NULL,
  `copyright_document_id` int(11) NOT NULL,
  `match_type` varchar(255) NOT NULL,
  `confidence` float NOT NULL,
  `reverted` tinyint(1) DEFAULT '0',
  `bad_match` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `docs` (`copyright_document_id`,`test_document_id`),
  KEY `reverted_badmatch` (`reverted`,`bad_match`),
  KEY `badmatch` (`bad_match`),
  KEY `index_copyright_filter_matches_on_test_document_id` (`test_document_id`),
  KEY `updated_reverted` (`updated_at`,`reverted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `copyright_protected_accounts` (
  `word_user_id` int(11) NOT NULL,
  `cms_only` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_copyright_protected_accounts_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `copyright_protected_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `copyrights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `display_order` int(11) DEFAULT '0',
  `image_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `display_order` (`display_order`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE `countries` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `code` char(2) CHARACTER SET latin1 NOT NULL,
  `country_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `country_quality_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_code` varchar(2) NOT NULL,
  `quality_score` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_country_quality_scores_on_country_code` (`country_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `customer_profiles` (
  `id` int(11) NOT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `params` text NOT NULL,
  `test` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `index_customer_profiles_on_id` (`id`),
  UNIQUE KEY `index_customer_profiles_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `doc_admin_infos` (
  `word_document_id` int(11) NOT NULL,
  `verified_adult` tinyint(1) NOT NULL DEFAULT '0',
  `show_404` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `document_audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `view_count` int(11) NOT NULL DEFAULT '0',
  `editor_word_user_id` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `locked_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_editor_word_user_status_view_count` (`editor_word_user_id`,`status`,`view_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `document_boosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `boosting_factor` float NOT NULL,
  `algo` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_algo` (`word_document_id`,`algo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `document_collecting_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `document_collection_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `status` int(11) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_document_collecting_requests_on_word_user_id` (`word_user_id`),
  KEY `index_document_collecting_requests_on_word_document_id` (`word_document_id`),
  KEY `doc_collecting_request_and_status` (`document_collection_id`,`status`),
  KEY `doc_collecting_request_and_created_at` (`document_collection_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `document_collectings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_collection_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `collection_type` tinyint(4) NOT NULL DEFAULT '1',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_collection_document` (`document_collection_id`,`word_document_id`),
  KEY `idx_document_collection_position` (`document_collection_id`,`position`),
  KEY `idx_document_collection_created` (`document_collection_id`,`created_at`),
  KEY `idx_document_collection_type` (`word_document_id`,`collection_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `document_collection_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_collection_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_document_collection` (`category_id`,`document_collection_id`),
  KEY `idx_document_collection` (`document_collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `document_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `canonical_document_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `html_description` text,
  `use_html_description` tinyint(1) NOT NULL DEFAULT '0',
  `collection_type` tinyint(4) NOT NULL DEFAULT '1',
  `format_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `privacy_type` tinyint(4) NOT NULL DEFAULT '1',
  `public_document_acceptance_type` tinyint(4) NOT NULL DEFAULT '0',
  `primary_language_id` smallint(6) NOT NULL DEFAULT '2',
  `document_collectings_count` int(11) NOT NULL DEFAULT '0',
  `pending_documents_count` int(11) NOT NULL DEFAULT '0',
  `popularity_score` float NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_canonical_document` (`canonical_document_id`),
  KEY `idx_privacy_type` (`privacy_type`),
  KEY `idx_collection_type` (`collection_type`),
  KEY `idx_user_privacy_type` (`word_user_id`,`privacy_type`),
  KEY `idx_user_collection_type` (`word_user_id`,`collection_type`),
  KEY `idx_primary_language` (`primary_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `editions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `written_work_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `admin_user_id` int(11) DEFAULT NULL,
  `source_type` tinyint(3) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_written_work` (`written_work_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `email_optouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `email_crc32` int(10) unsigned NOT NULL,
  `optout_type` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_email_crc32` (`email_crc32`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `email_verification_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_address_id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_email_verification_requests_on_code` (`code`),
  UNIQUE KEY `index_email_verification_requests_on_email_address_id` (`email_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `exclusions` (
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_exclusions_on_word_document_id` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `external_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `source_type` tinyint(4) NOT NULL DEFAULT '0',
  `source_external_id` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0',
  `document_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_source_type_source_external` (`source_type`,`source_external_id`),
  KEY `idx_status_score` (`status`,`score`),
  KEY `idx_name_source_type` (`name`,`source_type`),
  KEY `idx_status_updated` (`status`,`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `external_tags_word_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `external_tag_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_external_tag_document` (`external_tag_id`,`word_document_id`),
  KEY `idx_document_external_tag_count` (`word_document_id`,`external_tag_id`,`count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `facebook_users` (
  `facebook_id` bigint(20) unsigned NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `last_slurp_at` timestamp NULL DEFAULT NULL,
  `last_slurp_attempt_at` timestamp NULL DEFAULT NULL,
  `last_session_key_found_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `idx_facebook` (`facebook_id`),
  UNIQUE KEY `idx_user` (`word_user_id`),
  KEY `idx_last_slurp` (`last_slurp_at`,`last_slurp_attempt_at`),
  KEY `idx_last_session_key_found` (`last_session_key_found_at`,`last_slurp_at`,`last_slurp_attempt_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `featured_onboarding_users` (
  `word_user_id` int(11) NOT NULL,
  `position` tinyint(3) unsigned NOT NULL,
  UNIQUE KEY `idx_user` (`word_user_id`),
  KEY `idx_position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `featured_user_objects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `featured_id` int(11) NOT NULL,
  `featured_type` smallint(6) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user_featured` (`word_user_id`,`featured_type`,`featured_id`),
  KEY `latest_featured_by_type` (`word_user_id`,`featured_type`,`created_at`),
  KEY `features_for_object` (`featured_type`,`featured_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `flat_geo_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `country_id` smallint(6) NOT NULL,
  `sale_restricted` tinyint(1) NOT NULL DEFAULT '0',
  `context` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_country_context` (`word_document_id`,`country_id`,`context`),
  KEY `idx_document_country_context_sale_restricted` (`word_document_id`,`country_id`,`context`,`sale_restricted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `formats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word_upload_id` int(11) NOT NULL,
  `extension` varchar(6) NOT NULL,
  `uuid` varchar(40) CHARACTER SET latin1 NOT NULL,
  `original` tinyint(1) NOT NULL DEFAULT '0',
  `file_num` smallint(5) unsigned NOT NULL DEFAULT '0',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0',
  `height` smallint(5) unsigned NOT NULL DEFAULT '0',
  `width` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_upload_extension` (`word_upload_id`,`extension`),
  KEY `idx_uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `homepage_requests` (
  `word_document_id` int(11) NOT NULL,
  `writeup` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`word_document_id`),
  KEY `index_homepage_requests_on_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `homepage_rows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obj_type` int(11) NOT NULL DEFAULT '0',
  `obj_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `premium` tinyint(1) NOT NULL DEFAULT '0',
  `obj_params` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_type_id` (`obj_type`,`obj_id`),
  KEY `idx_position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `hotness_info` (
  `doc_id` int(10) unsigned NOT NULL,
  `rank` double unsigned NOT NULL DEFAULT '0',
  `promoted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`doc_id`),
  KEY `promoted_rank` (`promoted_at`,`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `imprint_memberships` (
  `imprint_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `idx_imprint_document` (`imprint_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `imprints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `publisher_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sequence` tinyint(4) NOT NULL,
  `bowker_code` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_publisher` (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `display_order` int(11) DEFAULT '0',
  `guess_name` varchar(100) DEFAULT NULL,
  `iso_639_1` char(2) DEFAULT NULL,
  `iso_639_2` char(3) DEFAULT NULL,
  `lcid` varchar(255) DEFAULT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `available` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_languages_on_guess_name` (`guess_name`),
  KEY `order_guess` (`display_order`,`guess_name`),
  KEY `iso_639_1_index` (`iso_639_1`),
  KEY `iso_639_2_index` (`iso_639_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `library_thing_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `times_favorited` int(11) DEFAULT NULL,
  `num_ratings` int(11) DEFAULT NULL,
  `avg_rating` float DEFAULT NULL,
  `num_reviews` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `mac_uploader_releases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(255) NOT NULL,
  `internal_version` varchar(255) NOT NULL,
  `dsa_signature` varchar(255) NOT NULL,
  `length` int(11) NOT NULL,
  `min_os_version` varchar(255) DEFAULT NULL,
  `release_notes` text NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_mac_uploader_releases_on_internal_version` (`internal_version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `mac_uploader_system_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) DEFAULT NULL,
  `lang` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `os_version` varchar(255) DEFAULT NULL,
  `cpu_frequency` int(11) DEFAULT NULL,
  `app_version` int(11) DEFAULT NULL,
  `cpu_subtype` int(11) DEFAULT NULL,
  `cpu_type` int(11) DEFAULT NULL,
  `cpu_count` int(11) DEFAULT NULL,
  `ram_size` int(11) DEFAULT NULL,
  `cpu_64_bit` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `magic_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `canonical_collection_id` int(11) DEFAULT NULL,
  `approved_collection_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name_overwritten` tinyint(1) NOT NULL DEFAULT '0',
  `editorial_word_user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_canonical_collection` (`canonical_collection_id`),
  UNIQUE KEY `idx_approved_collection` (`approved_collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `magic_collections_word_document_exclusions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `magic_collection_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_magic_collection_document` (`magic_collection_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `merged_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `original_document_id` int(11) NOT NULL,
  `duplicate_document_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_duplicate_document` (`duplicate_document_id`),
  KEY `idx_original_document` (`original_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `n_way_test_assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `browser_uuid` varchar(36) DEFAULT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `n_way_test_id` int(11) NOT NULL,
  `n_way_test_choice_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `unique_assignment_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_n_way_test_assignments_on_n_way_test_id_and_browser_uuid` (`n_way_test_id`,`browser_uuid`),
  UNIQUE KEY `index_n_way_test_assignments_on_n_way_test_id_and_word_user_id` (`n_way_test_id`,`word_user_id`),
  KEY `fuck4` (`n_way_test_choice_id`,`created_at`),
  KEY `updated_id` (`updated_at`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `n_way_test_choices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `n_way_test_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `weight` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `assignments` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_type` (`type`),
  KEY `idx_test_id` (`n_way_test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `n_way_test_goals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `goal_type` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `n_way_tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `test_version` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `sync_to_exact_target` tinyint(1) NOT NULL DEFAULT '0',
  `storage_engine` varchar(255) NOT NULL,
  `report_class` varchar(255) DEFAULT NULL,
  `description` text,
  `owner` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `started_at` datetime DEFAULT NULL,
  `ended_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_n_way_tests_on_name_and_test_version` (`name`,`test_version`),
  KEY `index_n_way_tests_on_storage_engine_and_active` (`storage_engine`,`active`),
  KEY `idx_deleted_created` (`deleted`,`created_at`),
  KEY `idx_sync_to_exact_target` (`sync_to_exact_target`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `optimizely_tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `optimizely_experiment_id` varchar(12) CHARACTER SET latin1 NOT NULL,
  `optimizely_variation_id` varchar(12) CHARACTER SET latin1 NOT NULL,
  `nway_test_id` int(11) NOT NULL,
  `nway_test_choice_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_experiment_variation_nway_test_nway_test_choice` (`optimizely_experiment_id`,`optimizely_variation_id`,`nway_test_id`,`nway_test_choice_id`),
  KEY `idx_nway_test` (`nway_test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `options` (
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `internal` tinyint(1) NOT NULL DEFAULT '0',
  `expose_to_client` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `name` (`name`),
  KEY `index_options_on_internal_and_name` (`internal`,`name`),
  KEY `index_options_on_expose_to_client` (`expose_to_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ordained_accounts` (
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_ordained_accounts_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `ordered_series_credits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `canonical_document_id` int(11) NOT NULL,
  `sum_credit_cost` smallint(6) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_canonical_document` (`canonical_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `paid_document_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_collection_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_paid_document_collections_on_document_collection_id` (`document_collection_id`),
  KEY `index_paid_document_collections_on_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `paid_document_reminder_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_paid_document_reminder_emails_on_wu_id_and_wd_id` (`word_user_id`,`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `paid_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `max_pages_to_show` int(11) DEFAULT NULL,
  `max_percentage_to_show` int(11) DEFAULT NULL,
  `page_range` varchar(255) DEFAULT NULL,
  `disable_search_highlighting` tinyint(1) NOT NULL DEFAULT '0',
  `page_calculation_method` varchar(255) NOT NULL DEFAULT 'automatic',
  `allow_indexing` tinyint(1) NOT NULL DEFAULT '1',
  `show_search_excerpts` tinyint(1) NOT NULL DEFAULT '0',
  `price` int(11) DEFAULT NULL,
  `offsite` tinyint(1) NOT NULL DEFAULT '0',
  `list_price` int(11) DEFAULT NULL,
  `credit_cost` smallint(5) unsigned NOT NULL DEFAULT '0',
  `show_full_section` tinyint(1) NOT NULL DEFAULT '1',
  `store` tinyint(1) NOT NULL DEFAULT '1',
  `always_display_front_matter` tinyint(1) NOT NULL DEFAULT '1',
  `always_display_back_matter` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `payment_profiles` (
  `id` int(11) NOT NULL,
  `customer_profile_id` int(11) NOT NULL,
  `addr_params` text NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remote_deleted` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `index_payment_profiles_on_id` (`id`),
  KEY `index_payment_profiles_on_customer_profile_id` (`customer_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `payments_store_earning_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `paid_at` datetime NOT NULL,
  `amount` int(11) NOT NULL,
  `gross` int(11) NOT NULL,
  `percentage_seller` int(11) NOT NULL,
  `credit_card_fee` int(11) NOT NULL,
  `drm_fee` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `refunded` tinyint(1) NOT NULL DEFAULT '0',
  `buyer_user_id` int(11) NOT NULL,
  `seller_user_id` int(11) NOT NULL,
  `item_type` varchar(255) NOT NULL DEFAULT 'WordDocument',
  `pricing_model_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_transaction` (`transaction_id`),
  KEY `idx_paid` (`paid_at`),
  KEY `idx_item_refunded` (`item_id`,`refunded`),
  KEY `idx_seller_user_paid` (`seller_user_id`,`paid_at`),
  KEY `idx_pricing_model` (`pricing_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `press_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `press_date` datetime NOT NULL,
  `link` varchar(255) NOT NULL,
  `link_text` varchar(255) NOT NULL,
  `intro` varchar(255) NOT NULL,
  `source` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_press_date` (`press_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `pricing_models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sellable_id` int(11) NOT NULL,
  `sellable_type` varchar(255) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `model_price` int(11) NOT NULL,
  `retail_price` int(11) NOT NULL,
  `seller_share_percent` int(11) NOT NULL,
  `country` varchar(2) DEFAULT NULL,
  `currency_code` char(3) CHARACTER SET latin1 NOT NULL DEFAULT 'USD',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sellable_country_active` (`sellable_type`,`sellable_id`,`country`,`active`),
  KEY `idx_seller_sellable_type_sellable_active` (`seller_id`,`sellable_type`,`sellable_id`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `browser_uuid` varchar(36) DEFAULT NULL,
  `review_id` int(11) DEFAULT NULL,
  `source` tinyint(4) NOT NULL DEFAULT '0',
  `ip_address` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ratings_on_browser_uuid_and_word_document_id` (`browser_uuid`,`word_document_id`),
  UNIQUE KEY `index_ratings_on_word_user_id_and_word_document_id` (`word_user_id`,`word_document_id`),
  UNIQUE KEY `idx_review` (`review_id`),
  KEY `index_ratings_on_word_document_id` (`word_document_id`),
  KEY `ip_address` (`ip_address`),
  KEY `idx_user_source_document` (`word_user_id`,`source`,`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `reading_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `removals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `explanation` text,
  `removal_type` int(11) DEFAULT '0',
  `fake` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `complete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fake` (`fake`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `reverted_copyright_dmca_removals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `removal_id` int(11) NOT NULL,
  `reversion_type` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_removal` (`removal_id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_upload_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `selected` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upload` (`word_upload_id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations_old` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `scribd_employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` tinyint(3) unsigned NOT NULL,
  `job_title` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `signature_url` varchar(255) DEFAULT NULL,
  `signature_quote` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `department` tinyint(3) unsigned NOT NULL,
  `long_description` text,
  PRIMARY KEY (`id`),
  KEY `idx_active_position` (`active`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `scribd_select_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scribd_select_id` int(11) NOT NULL,
  `document_collection_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_scribd_select_document_collection` (`scribd_select_id`,`document_collection_id`),
  KEY `idx_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `scribd_selects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merch_start_date` date NOT NULL,
  `merch_end_date` date NOT NULL,
  `format_type` tinyint(3) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_merch_start_date_merch_end_date_format_type` (`merch_start_date`,`merch_end_date`,`format_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `secure_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_upload_id` int(11) NOT NULL,
  `page_num` int(11) NOT NULL,
  `enc_key` varbinary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_secure_pages_on_word_upload_id_and_page_num` (`word_upload_id`,`page_num`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii;

CREATE TABLE `seller_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `payment_date` datetime NOT NULL,
  `payment_method` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `check_payee` varchar(255) DEFAULT '',
  `mailing_address` varchar(255) DEFAULT '',
  `paypal_email` varchar(255) DEFAULT '',
  `check_number` int(11) DEFAULT '0',
  `successful` tinyint(1) DEFAULT '1',
  `failure_reason` text,
  PRIMARY KEY (`id`),
  KEY `index_seller_payments_on_word_user_id` (`word_user_id`),
  KEY `index_seller_payments_on_payment_date` (`payment_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `sellers` (
  `word_user_id` int(11) NOT NULL,
  `payment_method` int(11) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `website` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `send_sale_email` tinyint(1) NOT NULL DEFAULT '1',
  `payout_percentage` float DEFAULT NULL,
  `paypal_email` varchar(255) DEFAULT NULL,
  `payment_schedule` int(11) DEFAULT '0',
  `payee_name` varchar(255) DEFAULT NULL,
  `payee_organization` varchar(255) DEFAULT NULL,
  `payee_organization_type` varchar(255) DEFAULT NULL,
  `payee_address` text,
  `guaranteed_payout` tinyint(1) NOT NULL DEFAULT '0',
  `revoked` tinyint(1) NOT NULL DEFAULT '0',
  `review_whitelist` tinyint(1) NOT NULL DEFAULT '0',
  `invalid_address` tinyint(1) NOT NULL DEFAULT '0',
  `check_payable` varchar(255) DEFAULT NULL,
  `taxable` tinyint(1) NOT NULL DEFAULT '0',
  `non_scribd_pricing_model` tinyint(1) NOT NULL DEFAULT '0',
  `agency_share_percent` tinyint(4) DEFAULT NULL,
  `wholesale_share_percent` tinyint(4) DEFAULT NULL,
  `seller_type` tinyint(4) NOT NULL DEFAULT '0',
  `submitted_tax_form` tinyint(4) NOT NULL DEFAULT '0',
  UNIQUE KEY `index_sellers_on_word_user_id` (`word_user_id`),
  KEY `idx_seller_type` (`seller_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `send_to_friends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) DEFAULT '0',
  `word_user_id` int(11) DEFAULT '0',
  `session_id` varchar(100) DEFAULT NULL,
  `ip_address` varchar(16) DEFAULT NULL,
  `message` mediumtext,
  `name` varchar(200) DEFAULT NULL,
  `emails` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `facebook` int(11) DEFAULT '0',
  `ids` text,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sharing_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `options` blob,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_sharing_preferences_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `spam_exempt_users` (
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `spam_geo_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule` varchar(255) NOT NULL,
  `country_or_continent` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_spam_geo_rules_on_rule_and_country_or_continent` (`rule`,`country_or_continent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `twitter_access_tokens` (
  `word_user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `twitter_user_id` bigint(20) unsigned NOT NULL,
  `status_id` int(11) unsigned DEFAULT NULL,
  UNIQUE KEY `idx_user` (`word_user_id`),
  UNIQUE KEY `idx_twitter_user` (`twitter_user_id`),
  KEY `idx_token` (`token`),
  KEY `idx_status` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `twitter_user_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `setup_context` varchar(60) NOT NULL,
  `connection_state` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `all_columns` (`setup_context`,`connection_state`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `unlimited_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_email_options` (
  `word_user_id` int(11) NOT NULL,
  `promotional_opt_in` tinyint(1) NOT NULL DEFAULT '0',
  `promotional_opt_in_date` date DEFAULT NULL,
  `stoplisted` tinyint(1) DEFAULT NULL,
  `stoplisted_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `welcome_email_sent_date` date DEFAULT NULL,
  UNIQUE KEY `index_user_email_options_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_flag_counts` (
  `total_flags` int(11) NOT NULL,
  `dismissed_flags` int(11) DEFAULT NULL,
  `indexed_flag_count` int(11) DEFAULT NULL,
  `flagged_object_id` int(11) NOT NULL,
  `flagged_object_type` varchar(255) NOT NULL,
  UNIQUE KEY `index_user_flag_counts_on_flagged_object` (`flagged_object_id`,`flagged_object_type`),
  KEY `index_user_flag_counts_on_total_flags` (`total_flags`),
  KEY `index_user_flag_counts_on_indexed_flag_count` (`indexed_flag_count`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_flag_exclusions` (
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_user_flag_exclusions_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_flags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flagger_id` int(11) DEFAULT NULL,
  `ip_address` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `dismissed` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` datetime DEFAULT NULL,
  `flagged_object_id` int(11) NOT NULL,
  `flagged_object_type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_user_flags_on_flagged_object` (`flagged_object_id`,`flagged_object_type`,`ip_address`),
  KEY `index_user_flags_on_created_at` (`created_at`),
  KEY `index_user_flags_on_word_user_id_and_ip_address` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_metadata` (
  `word_user_id` int(11) NOT NULL,
  `settings_hash` mediumtext,
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `user_passwords` (
  `word_user_id` int(11) NOT NULL,
  `encrypted_password` varchar(255) CHARACTER SET latin1 NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `num_documents` int(10) unsigned NOT NULL DEFAULT '0',
  `readcasts` int(10) unsigned NOT NULL DEFAULT '0',
  `authored_documents` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `word_document_publication_dates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `publish_on` date NOT NULL,
  `available_for_pmp_on` date DEFAULT NULL,
  `expires_on` date DEFAULT NULL,
  `published_on_scribd_at` datetime DEFAULT NULL,
  `graceful_deletion_settings_hash` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_document_publish_on` (`word_document_id`,`publish_on`),
  KEY `idx_available_for_pmp` (`available_for_pmp_on`),
  KEY `idx_expires` (`expires_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `word_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_upload_id` int(11) NOT NULL,
  `api_account_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(1000) DEFAULT NULL,
  `slug` varchar(200) NOT NULL DEFAULT '',
  `description` varchar(4000) DEFAULT NULL,
  `copyright_id` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `word_download` tinyint(1) NOT NULL DEFAULT '1',
  `text_download` tinyint(1) NOT NULL DEFAULT '1',
  `pdf_download` tinyint(1) NOT NULL DEFAULT '1',
  `all_download` tinyint(1) NOT NULL DEFAULT '1',
  `download_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `thumbnail_generated` tinyint(1) NOT NULL DEFAULT '1',
  `converted` tinyint(1) NOT NULL DEFAULT '0',
  `submitted` tinyint(1) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `private` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `show_comments` tinyint(1) NOT NULL DEFAULT '1',
  `removal_id` int(11) NOT NULL DEFAULT '0',
  `language_id` smallint(6) NOT NULL DEFAULT '2',
  `upload_source` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `document_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `flag_status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spam_status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `bad_document` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `unpublished_reason` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `series_membership` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `available_for_pmp` tinyint(1) NOT NULL DEFAULT '0',
  `scrambled_fonts` tinyint(1) NOT NULL DEFAULT '0',
  `staging` tinyint(1) NOT NULL DEFAULT '0',
  `secret_password` varchar(50) DEFAULT NULL,
  `access_key` varchar(50) DEFAULT NULL,
  `view_mode` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `page_count` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `extension` varchar(5) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upload` (`word_upload_id`),
  KEY `idx_created` (`created_at`),
  KEY `idx_updated` (`updated_at`),
  KEY `idx_published` (`published`),
  KEY `idx_published_created` (`published`,`created_at`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_user_created` (`word_user_id`,`created_at`),
  KEY `idx_user_published` (`word_user_id`,`published`),
  KEY `idx_api_account` (`api_account_id`),
  KEY `idx_removal` (`removal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

CREATE TABLE `word_documents_word_tags` (
  `word_document_id` int(11) NOT NULL,
  `word_tag_id` int(11) NOT NULL,
  `tagging_source` tinyint(4) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '1',
  UNIQUE KEY `idx_tag_document_tagging_source` (`word_tag_id`,`word_document_id`,`tagging_source`),
  KEY `idx_document_tagging_source_count` (`word_document_id`,`tagging_source`,`count`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `word_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `machine_made` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `word_uploads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `conversion_status` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `format_flags` int(10) unsigned NOT NULL DEFAULT '0',
  `original_filename` varchar(400) DEFAULT NULL,
  `extension` varchar(5) DEFAULT NULL,
  `ip_address` int(10) unsigned NOT NULL DEFAULT '0',
  `character_count` int(10) unsigned NOT NULL DEFAULT '0',
  `word_count` int(10) unsigned NOT NULL DEFAULT '0',
  `paragraph_count` int(10) unsigned NOT NULL DEFAULT '0',
  `page_count` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ratio` float NOT NULL DEFAULT '0',
  `guid` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `md5` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `copyright_match` int(11) NOT NULL DEFAULT '0',
  `language_id` smallint(6) NOT NULL DEFAULT '2',
  `slurp` varchar(300) DEFAULT NULL,
  `slurp_crc32` int(10) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `converted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_slurp_crc32` (`slurp_crc32`),
  KEY `idx_md5` (`md5`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `word_user_device_downloads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_device_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_device_document` (`word_user_device_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `word_user_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `uuid` varchar(255) CHARACTER SET latin1 NOT NULL,
  `device_type` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_uuid` (`word_user_id`,`uuid`),
  KEY `idx_user_device_type` (`word_user_id`,`device_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `word_user_low_cardinality_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facebook_connection_state` varchar(60) NOT NULL,
  `facebook_setup_context` varchar(60) NOT NULL DEFAULT 'none',
  `scribd_activity_privacy` varchar(60) NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uniqueness` (`facebook_connection_state`,`facebook_setup_context`,`scribd_activity_privacy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `word_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(200) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `slug` varchar(200) NOT NULL DEFAULT '',
  `ip_address` int(10) unsigned NOT NULL DEFAULT '0',
  `api_account_id` int(11) DEFAULT NULL,
  `status_id` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `dimension1_id` int(11) DEFAULT NULL,
  `dimension2_id` int(11) DEFAULT NULL,
  `dimension3_id` int(11) DEFAULT NULL,
  `feature_flags` int(10) unsigned NOT NULL DEFAULT '0',
  `primary_contribution_type` tinyint(3) unsigned NOT NULL DEFAULT '61',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `password_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_login` (`login`),
  KEY `idx_ip_address_created` (`ip_address`,`created_at`),
  KEY `idx_created` (`created_at`),
  KEY `idx_updated` (`updated_at`),
  KEY `idx_status` (`status_id`),
  KEY `idx_dimension1` (`dimension1_id`),
  KEY `idx_dimension2` (`dimension2_id`),
  KEY `idx_dimension3` (`dimension3_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `written_works` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workcode` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_library_thing_workcode` (`workcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20110602220731');

INSERT INTO schema_migrations (version) VALUES ('20110602224911');

INSERT INTO schema_migrations (version) VALUES ('20110603173137');

INSERT INTO schema_migrations (version) VALUES ('20110603204147');

INSERT INTO schema_migrations (version) VALUES ('20110607203239');

INSERT INTO schema_migrations (version) VALUES ('20110607215334');

INSERT INTO schema_migrations (version) VALUES ('20110608005052');

INSERT INTO schema_migrations (version) VALUES ('20110610175230');

INSERT INTO schema_migrations (version) VALUES ('20110610222928');

INSERT INTO schema_migrations (version) VALUES ('20110613223727');

INSERT INTO schema_migrations (version) VALUES ('20110614184445');

INSERT INTO schema_migrations (version) VALUES ('20110614190647');

INSERT INTO schema_migrations (version) VALUES ('20110615011638');

INSERT INTO schema_migrations (version) VALUES ('20110616010127');

INSERT INTO schema_migrations (version) VALUES ('20110616014409');

INSERT INTO schema_migrations (version) VALUES ('20110616181007');

INSERT INTO schema_migrations (version) VALUES ('20110616183332');

INSERT INTO schema_migrations (version) VALUES ('20110617182010');

INSERT INTO schema_migrations (version) VALUES ('20110620204933');

INSERT INTO schema_migrations (version) VALUES ('20110620214337');

INSERT INTO schema_migrations (version) VALUES ('20110622221011');

INSERT INTO schema_migrations (version) VALUES ('20110622225523');

INSERT INTO schema_migrations (version) VALUES ('20110622230113');

INSERT INTO schema_migrations (version) VALUES ('20110623001401');

INSERT INTO schema_migrations (version) VALUES ('20110623012116');

INSERT INTO schema_migrations (version) VALUES ('20110623012139');

INSERT INTO schema_migrations (version) VALUES ('20110623171630');

INSERT INTO schema_migrations (version) VALUES ('20110623174155');

INSERT INTO schema_migrations (version) VALUES ('20110623184819');

INSERT INTO schema_migrations (version) VALUES ('20110624194557');

INSERT INTO schema_migrations (version) VALUES ('20110624203607');

INSERT INTO schema_migrations (version) VALUES ('20110625000711');

INSERT INTO schema_migrations (version) VALUES ('20110625193706');

INSERT INTO schema_migrations (version) VALUES ('20110625224546');

INSERT INTO schema_migrations (version) VALUES ('20110625224646');

INSERT INTO schema_migrations (version) VALUES ('20110625224745');

INSERT INTO schema_migrations (version) VALUES ('20110628180418');

INSERT INTO schema_migrations (version) VALUES ('20110628230455');

INSERT INTO schema_migrations (version) VALUES ('20110628230517');

INSERT INTO schema_migrations (version) VALUES ('20110628234023');

INSERT INTO schema_migrations (version) VALUES ('20110629010329');

INSERT INTO schema_migrations (version) VALUES ('20110629192928');

INSERT INTO schema_migrations (version) VALUES ('20110701061230');

INSERT INTO schema_migrations (version) VALUES ('20110705222732');

INSERT INTO schema_migrations (version) VALUES ('20110705232806');

INSERT INTO schema_migrations (version) VALUES ('20110706184834');

INSERT INTO schema_migrations (version) VALUES ('20110706184935');

INSERT INTO schema_migrations (version) VALUES ('20110707000716');

INSERT INTO schema_migrations (version) VALUES ('20110709003210');

INSERT INTO schema_migrations (version) VALUES ('20110712012900');

INSERT INTO schema_migrations (version) VALUES ('20110714011847');

INSERT INTO schema_migrations (version) VALUES ('20110714212208');

INSERT INTO schema_migrations (version) VALUES ('20110714231901');

INSERT INTO schema_migrations (version) VALUES ('20110714235618');

INSERT INTO schema_migrations (version) VALUES ('20110715203547');

INSERT INTO schema_migrations (version) VALUES ('20110715211557');

INSERT INTO schema_migrations (version) VALUES ('20110718184835');

INSERT INTO schema_migrations (version) VALUES ('20110719175154');

INSERT INTO schema_migrations (version) VALUES ('20110719175233');

INSERT INTO schema_migrations (version) VALUES ('20110719181754');

INSERT INTO schema_migrations (version) VALUES ('20110719204809');

INSERT INTO schema_migrations (version) VALUES ('20110721024021');

INSERT INTO schema_migrations (version) VALUES ('20110721231235');

INSERT INTO schema_migrations (version) VALUES ('20110725192841');

INSERT INTO schema_migrations (version) VALUES ('20110726203628');

INSERT INTO schema_migrations (version) VALUES ('20110726230425');

INSERT INTO schema_migrations (version) VALUES ('20110727010021');

INSERT INTO schema_migrations (version) VALUES ('20110727191330');

INSERT INTO schema_migrations (version) VALUES ('20110729193230');

INSERT INTO schema_migrations (version) VALUES ('20110802013846');

INSERT INTO schema_migrations (version) VALUES ('20110802235020');

INSERT INTO schema_migrations (version) VALUES ('20110803014908');

INSERT INTO schema_migrations (version) VALUES ('20110803193133');

INSERT INTO schema_migrations (version) VALUES ('20110803194518');

INSERT INTO schema_migrations (version) VALUES ('20110803232716');

INSERT INTO schema_migrations (version) VALUES ('20110804002701');

INSERT INTO schema_migrations (version) VALUES ('20110804185242');

INSERT INTO schema_migrations (version) VALUES ('20110804231851');

INSERT INTO schema_migrations (version) VALUES ('20110808220029');

INSERT INTO schema_migrations (version) VALUES ('20110810180818');

INSERT INTO schema_migrations (version) VALUES ('20110811001354');

INSERT INTO schema_migrations (version) VALUES ('20110811154710');

INSERT INTO schema_migrations (version) VALUES ('20110812235142');

INSERT INTO schema_migrations (version) VALUES ('20110820001959');

INSERT INTO schema_migrations (version) VALUES ('20110823002655');

INSERT INTO schema_migrations (version) VALUES ('20110831001244');

INSERT INTO schema_migrations (version) VALUES ('20110901213056');

INSERT INTO schema_migrations (version) VALUES ('20110907230506');

INSERT INTO schema_migrations (version) VALUES ('20110912202142');

INSERT INTO schema_migrations (version) VALUES ('20110913013004');

INSERT INTO schema_migrations (version) VALUES ('20110913210449');

INSERT INTO schema_migrations (version) VALUES ('20110915183830');

INSERT INTO schema_migrations (version) VALUES ('20110916195533');

INSERT INTO schema_migrations (version) VALUES ('20110916212834');

INSERT INTO schema_migrations (version) VALUES ('20110919191424');

INSERT INTO schema_migrations (version) VALUES ('20110919222743');

INSERT INTO schema_migrations (version) VALUES ('20110919223752');

INSERT INTO schema_migrations (version) VALUES ('20110920172841');

INSERT INTO schema_migrations (version) VALUES ('20110920193626');

INSERT INTO schema_migrations (version) VALUES ('20110920212046');

INSERT INTO schema_migrations (version) VALUES ('20110920230010');

INSERT INTO schema_migrations (version) VALUES ('20110921181015');

INSERT INTO schema_migrations (version) VALUES ('20110921230517');

INSERT INTO schema_migrations (version) VALUES ('20110922000821');

INSERT INTO schema_migrations (version) VALUES ('20110922001149');

INSERT INTO schema_migrations (version) VALUES ('20110922005042');

INSERT INTO schema_migrations (version) VALUES ('20110922201453');

INSERT INTO schema_migrations (version) VALUES ('20110922214107');

INSERT INTO schema_migrations (version) VALUES ('20110922222600');

INSERT INTO schema_migrations (version) VALUES ('20110922235031');

INSERT INTO schema_migrations (version) VALUES ('20110923003453');

INSERT INTO schema_migrations (version) VALUES ('20110923030650');

INSERT INTO schema_migrations (version) VALUES ('20110923093415');

INSERT INTO schema_migrations (version) VALUES ('20110928204331');

INSERT INTO schema_migrations (version) VALUES ('20110929195547');

INSERT INTO schema_migrations (version) VALUES ('20111004224242');

INSERT INTO schema_migrations (version) VALUES ('20111005020726');

INSERT INTO schema_migrations (version) VALUES ('20111005182428');

INSERT INTO schema_migrations (version) VALUES ('20111006190529');

INSERT INTO schema_migrations (version) VALUES ('20111007004505');

INSERT INTO schema_migrations (version) VALUES ('20111007004610');

INSERT INTO schema_migrations (version) VALUES ('20111007230003');

INSERT INTO schema_migrations (version) VALUES ('20111007235307');

INSERT INTO schema_migrations (version) VALUES ('20111008005553');

INSERT INTO schema_migrations (version) VALUES ('20111011002611');

INSERT INTO schema_migrations (version) VALUES ('20111011223251');

INSERT INTO schema_migrations (version) VALUES ('20111012223722');

INSERT INTO schema_migrations (version) VALUES ('20111013200043');

INSERT INTO schema_migrations (version) VALUES ('20111014012959');

INSERT INTO schema_migrations (version) VALUES ('20111014224345');

INSERT INTO schema_migrations (version) VALUES ('20111019202448');

INSERT INTO schema_migrations (version) VALUES ('20111020234049');

INSERT INTO schema_migrations (version) VALUES ('20111021142403');

INSERT INTO schema_migrations (version) VALUES ('20111021191420');

INSERT INTO schema_migrations (version) VALUES ('20111025181939');

INSERT INTO schema_migrations (version) VALUES ('20111026233356');

INSERT INTO schema_migrations (version) VALUES ('20111027202708');

INSERT INTO schema_migrations (version) VALUES ('20111027205053');

INSERT INTO schema_migrations (version) VALUES ('20111101001845');

INSERT INTO schema_migrations (version) VALUES ('20111101203411');

INSERT INTO schema_migrations (version) VALUES ('20111102011730');

INSERT INTO schema_migrations (version) VALUES ('20111103003603');

INSERT INTO schema_migrations (version) VALUES ('20111108202436');

INSERT INTO schema_migrations (version) VALUES ('20111108233726');

INSERT INTO schema_migrations (version) VALUES ('20111109022629');

INSERT INTO schema_migrations (version) VALUES ('20111109231054');

INSERT INTO schema_migrations (version) VALUES ('20111112012654');

INSERT INTO schema_migrations (version) VALUES ('20111114221958');

INSERT INTO schema_migrations (version) VALUES ('20111115234819');

INSERT INTO schema_migrations (version) VALUES ('20111122003627');

INSERT INTO schema_migrations (version) VALUES ('20111122014630');

INSERT INTO schema_migrations (version) VALUES ('20111128232334');

INSERT INTO schema_migrations (version) VALUES ('20111201013104');

INSERT INTO schema_migrations (version) VALUES ('20111201204820');

INSERT INTO schema_migrations (version) VALUES ('20111203004932');

INSERT INTO schema_migrations (version) VALUES ('20111215234239');

INSERT INTO schema_migrations (version) VALUES ('20111221203334');

INSERT INTO schema_migrations (version) VALUES ('20111222194205');

INSERT INTO schema_migrations (version) VALUES ('20120117185038');

INSERT INTO schema_migrations (version) VALUES ('20120117232328');

INSERT INTO schema_migrations (version) VALUES ('20120118004651');

INSERT INTO schema_migrations (version) VALUES ('20120131231948');

INSERT INTO schema_migrations (version) VALUES ('20120201011717');

INSERT INTO schema_migrations (version) VALUES ('20120202031114');

INSERT INTO schema_migrations (version) VALUES ('20120202212825');

INSERT INTO schema_migrations (version) VALUES ('20120206220326');

INSERT INTO schema_migrations (version) VALUES ('20120209223452');

INSERT INTO schema_migrations (version) VALUES ('20120213225353');

INSERT INTO schema_migrations (version) VALUES ('20120214212530');

INSERT INTO schema_migrations (version) VALUES ('20120214214938');

INSERT INTO schema_migrations (version) VALUES ('20120215234553');

INSERT INTO schema_migrations (version) VALUES ('20120216022125');

INSERT INTO schema_migrations (version) VALUES ('20120216023224');

INSERT INTO schema_migrations (version) VALUES ('20120216025956');

INSERT INTO schema_migrations (version) VALUES ('20120216025957');

INSERT INTO schema_migrations (version) VALUES ('20120216195718');

INSERT INTO schema_migrations (version) VALUES ('20120216222753');

INSERT INTO schema_migrations (version) VALUES ('20120220061813');

INSERT INTO schema_migrations (version) VALUES ('20120222235914');

INSERT INTO schema_migrations (version) VALUES ('20120223194212');

INSERT INTO schema_migrations (version) VALUES ('20120227115903');

INSERT INTO schema_migrations (version) VALUES ('20120227202304');

INSERT INTO schema_migrations (version) VALUES ('20120227204222');

INSERT INTO schema_migrations (version) VALUES ('20120229195512');

INSERT INTO schema_migrations (version) VALUES ('20120229204035');

INSERT INTO schema_migrations (version) VALUES ('20120306000606');

INSERT INTO schema_migrations (version) VALUES ('20120306215242');

INSERT INTO schema_migrations (version) VALUES ('20120307192909');

INSERT INTO schema_migrations (version) VALUES ('20120309010011');

INSERT INTO schema_migrations (version) VALUES ('20120310062833');

INSERT INTO schema_migrations (version) VALUES ('20120310214646');

INSERT INTO schema_migrations (version) VALUES ('20120312201135');

INSERT INTO schema_migrations (version) VALUES ('20120316000202');

INSERT INTO schema_migrations (version) VALUES ('20120316042432');

INSERT INTO schema_migrations (version) VALUES ('20120320202128');

INSERT INTO schema_migrations (version) VALUES ('20120320210248');

INSERT INTO schema_migrations (version) VALUES ('20120320210317');

INSERT INTO schema_migrations (version) VALUES ('20120320211152');

INSERT INTO schema_migrations (version) VALUES ('20120321195128');

INSERT INTO schema_migrations (version) VALUES ('20120321204120');

INSERT INTO schema_migrations (version) VALUES ('20120321212025');

INSERT INTO schema_migrations (version) VALUES ('20120327193509');

INSERT INTO schema_migrations (version) VALUES ('20120327225520');

INSERT INTO schema_migrations (version) VALUES ('20120327231836');

INSERT INTO schema_migrations (version) VALUES ('20120328171958');

INSERT INTO schema_migrations (version) VALUES ('20120329005627');

INSERT INTO schema_migrations (version) VALUES ('20120330235153');

INSERT INTO schema_migrations (version) VALUES ('20120402191025');

INSERT INTO schema_migrations (version) VALUES ('20120402191026');

INSERT INTO schema_migrations (version) VALUES ('20120402205633');

INSERT INTO schema_migrations (version) VALUES ('20120403000442');

INSERT INTO schema_migrations (version) VALUES ('20120404000427');

INSERT INTO schema_migrations (version) VALUES ('20120404001127');

INSERT INTO schema_migrations (version) VALUES ('20120404002921');

INSERT INTO schema_migrations (version) VALUES ('20120405002328');

INSERT INTO schema_migrations (version) VALUES ('20120405020615');

INSERT INTO schema_migrations (version) VALUES ('20120406154937');

INSERT INTO schema_migrations (version) VALUES ('20120407184727');

INSERT INTO schema_migrations (version) VALUES ('20120409222534');

INSERT INTO schema_migrations (version) VALUES ('20120409232400');

INSERT INTO schema_migrations (version) VALUES ('20120411020700');

INSERT INTO schema_migrations (version) VALUES ('20120412025405');

INSERT INTO schema_migrations (version) VALUES ('20120413204849');

INSERT INTO schema_migrations (version) VALUES ('20120417015645');

INSERT INTO schema_migrations (version) VALUES ('20120417150541');

INSERT INTO schema_migrations (version) VALUES ('20120417211511');

INSERT INTO schema_migrations (version) VALUES ('20120420214005');

INSERT INTO schema_migrations (version) VALUES ('20120420222130');

INSERT INTO schema_migrations (version) VALUES ('20120425214402');

INSERT INTO schema_migrations (version) VALUES ('20120430184341');

INSERT INTO schema_migrations (version) VALUES ('20120430195133');

INSERT INTO schema_migrations (version) VALUES ('20120430215949');

INSERT INTO schema_migrations (version) VALUES ('20120430220055');

INSERT INTO schema_migrations (version) VALUES ('20120430220639');

INSERT INTO schema_migrations (version) VALUES ('20120430230550');

INSERT INTO schema_migrations (version) VALUES ('20120430232330');

INSERT INTO schema_migrations (version) VALUES ('20120430233830');

INSERT INTO schema_migrations (version) VALUES ('20120501013006');

INSERT INTO schema_migrations (version) VALUES ('20120501184813');

INSERT INTO schema_migrations (version) VALUES ('20120501194747');

INSERT INTO schema_migrations (version) VALUES ('20120501212857');

INSERT INTO schema_migrations (version) VALUES ('20120501212918');

INSERT INTO schema_migrations (version) VALUES ('20120501214232');

INSERT INTO schema_migrations (version) VALUES ('20120501221517');

INSERT INTO schema_migrations (version) VALUES ('20120502193455');

INSERT INTO schema_migrations (version) VALUES ('20120503031043');

INSERT INTO schema_migrations (version) VALUES ('20120503225547');

INSERT INTO schema_migrations (version) VALUES ('20120504214832');

INSERT INTO schema_migrations (version) VALUES ('20120505050428');

INSERT INTO schema_migrations (version) VALUES ('20120505231231');

INSERT INTO schema_migrations (version) VALUES ('20120508112356');

INSERT INTO schema_migrations (version) VALUES ('20120508172830');

INSERT INTO schema_migrations (version) VALUES ('20120509170631');

INSERT INTO schema_migrations (version) VALUES ('20120510173229');

INSERT INTO schema_migrations (version) VALUES ('20120510205138');

INSERT INTO schema_migrations (version) VALUES ('20120511180740');

INSERT INTO schema_migrations (version) VALUES ('20120515205656');

INSERT INTO schema_migrations (version) VALUES ('20120516183417');

INSERT INTO schema_migrations (version) VALUES ('20120516221946');

INSERT INTO schema_migrations (version) VALUES ('20120516230857');

INSERT INTO schema_migrations (version) VALUES ('20120517000615');

INSERT INTO schema_migrations (version) VALUES ('20120517001229');

INSERT INTO schema_migrations (version) VALUES ('20120517011347');

INSERT INTO schema_migrations (version) VALUES ('20120518035826');

INSERT INTO schema_migrations (version) VALUES ('20120518185158');

INSERT INTO schema_migrations (version) VALUES ('20120518185235');

INSERT INTO schema_migrations (version) VALUES ('20120518225334');

INSERT INTO schema_migrations (version) VALUES ('20120519014217');

INSERT INTO schema_migrations (version) VALUES ('20120521180205');

INSERT INTO schema_migrations (version) VALUES ('20120522003411');

INSERT INTO schema_migrations (version) VALUES ('20120522004924');

INSERT INTO schema_migrations (version) VALUES ('20120522022916');

INSERT INTO schema_migrations (version) VALUES ('20120522183420');

INSERT INTO schema_migrations (version) VALUES ('20120523040615');

INSERT INTO schema_migrations (version) VALUES ('20120523211934');

INSERT INTO schema_migrations (version) VALUES ('20120525011413');

INSERT INTO schema_migrations (version) VALUES ('20120525182235');

INSERT INTO schema_migrations (version) VALUES ('20120527221237');

INSERT INTO schema_migrations (version) VALUES ('20120527221345');

INSERT INTO schema_migrations (version) VALUES ('20120527221455');

INSERT INTO schema_migrations (version) VALUES ('20120528180435');

INSERT INTO schema_migrations (version) VALUES ('20120529162927');

INSERT INTO schema_migrations (version) VALUES ('20120530194830');

INSERT INTO schema_migrations (version) VALUES ('20120530200920');

INSERT INTO schema_migrations (version) VALUES ('20120530210124');

INSERT INTO schema_migrations (version) VALUES ('20120531052410');

INSERT INTO schema_migrations (version) VALUES ('20120531204906');

INSERT INTO schema_migrations (version) VALUES ('20120531233938');

INSERT INTO schema_migrations (version) VALUES ('20120604183527');

INSERT INTO schema_migrations (version) VALUES ('20120605184905');

INSERT INTO schema_migrations (version) VALUES ('20120606001819');

INSERT INTO schema_migrations (version) VALUES ('20120606190001');

INSERT INTO schema_migrations (version) VALUES ('20120606195456');

INSERT INTO schema_migrations (version) VALUES ('20120606214534');

INSERT INTO schema_migrations (version) VALUES ('20120607205035');

INSERT INTO schema_migrations (version) VALUES ('20120608200120');

INSERT INTO schema_migrations (version) VALUES ('20120608235554');

INSERT INTO schema_migrations (version) VALUES ('20120611165332');

INSERT INTO schema_migrations (version) VALUES ('20120611191759');

INSERT INTO schema_migrations (version) VALUES ('20120611233427');

INSERT INTO schema_migrations (version) VALUES ('20120613180954');

INSERT INTO schema_migrations (version) VALUES ('20120618013456');

INSERT INTO schema_migrations (version) VALUES ('20120619193801');

INSERT INTO schema_migrations (version) VALUES ('20120620221520');

INSERT INTO schema_migrations (version) VALUES ('20120621234050');

INSERT INTO schema_migrations (version) VALUES ('20120623021514');

INSERT INTO schema_migrations (version) VALUES ('20120626202050');

INSERT INTO schema_migrations (version) VALUES ('20120627193022');

INSERT INTO schema_migrations (version) VALUES ('20120628211347');

INSERT INTO schema_migrations (version) VALUES ('20120629160845');

INSERT INTO schema_migrations (version) VALUES ('20120702215906');

INSERT INTO schema_migrations (version) VALUES ('20120703200312');

INSERT INTO schema_migrations (version) VALUES ('20120704003022');

INSERT INTO schema_migrations (version) VALUES ('20120709225351');

INSERT INTO schema_migrations (version) VALUES ('20120711010358');

INSERT INTO schema_migrations (version) VALUES ('20120713173510');

INSERT INTO schema_migrations (version) VALUES ('20120716200258');

INSERT INTO schema_migrations (version) VALUES ('20120717175543');

INSERT INTO schema_migrations (version) VALUES ('20120717215121');

INSERT INTO schema_migrations (version) VALUES ('20120717233519');

INSERT INTO schema_migrations (version) VALUES ('20120718022942');

INSERT INTO schema_migrations (version) VALUES ('20120718182756');

INSERT INTO schema_migrations (version) VALUES ('20120719053215');

INSERT INTO schema_migrations (version) VALUES ('20120719235621');

INSERT INTO schema_migrations (version) VALUES ('20120723184848');

INSERT INTO schema_migrations (version) VALUES ('20120723212445');

INSERT INTO schema_migrations (version) VALUES ('20120724204933');

INSERT INTO schema_migrations (version) VALUES ('20120725212543');

INSERT INTO schema_migrations (version) VALUES ('20120725214642');

INSERT INTO schema_migrations (version) VALUES ('20120726010444');

INSERT INTO schema_migrations (version) VALUES ('20120726184217');

INSERT INTO schema_migrations (version) VALUES ('20120726190055');

INSERT INTO schema_migrations (version) VALUES ('20120801004351');

INSERT INTO schema_migrations (version) VALUES ('20120801052429');

INSERT INTO schema_migrations (version) VALUES ('20120801205013');

INSERT INTO schema_migrations (version) VALUES ('20120801234305');

INSERT INTO schema_migrations (version) VALUES ('20120802231151');

INSERT INTO schema_migrations (version) VALUES ('20120803001930');

INSERT INTO schema_migrations (version) VALUES ('20120803064842');

INSERT INTO schema_migrations (version) VALUES ('20120803075927');

INSERT INTO schema_migrations (version) VALUES ('20120803095847');

INSERT INTO schema_migrations (version) VALUES ('20120803163139');

INSERT INTO schema_migrations (version) VALUES ('20120806183220');

INSERT INTO schema_migrations (version) VALUES ('20120806193603');

INSERT INTO schema_migrations (version) VALUES ('20120808204105');

INSERT INTO schema_migrations (version) VALUES ('20120808234400');

INSERT INTO schema_migrations (version) VALUES ('20120808234640');

INSERT INTO schema_migrations (version) VALUES ('20120809003424');

INSERT INTO schema_migrations (version) VALUES ('20120809185605');

INSERT INTO schema_migrations (version) VALUES ('20120809210246');

INSERT INTO schema_migrations (version) VALUES ('20120809231401');

INSERT INTO schema_migrations (version) VALUES ('20120809233515');

INSERT INTO schema_migrations (version) VALUES ('20120814184033');

INSERT INTO schema_migrations (version) VALUES ('20120814202820');

INSERT INTO schema_migrations (version) VALUES ('20120816010237');

INSERT INTO schema_migrations (version) VALUES ('20120816010557');

INSERT INTO schema_migrations (version) VALUES ('20120822231537');

INSERT INTO schema_migrations (version) VALUES ('20120824011915');

INSERT INTO schema_migrations (version) VALUES ('20120824195827');

INSERT INTO schema_migrations (version) VALUES ('20120828224333');

INSERT INTO schema_migrations (version) VALUES ('20120830211327');

INSERT INTO schema_migrations (version) VALUES ('20120906182659');

INSERT INTO schema_migrations (version) VALUES ('20120911153327');

INSERT INTO schema_migrations (version) VALUES ('20120913184229');

INSERT INTO schema_migrations (version) VALUES ('20120913204246');

INSERT INTO schema_migrations (version) VALUES ('20120914001129');

INSERT INTO schema_migrations (version) VALUES ('20120914174355');

INSERT INTO schema_migrations (version) VALUES ('20120914213230');

INSERT INTO schema_migrations (version) VALUES ('20120914230810');

INSERT INTO schema_migrations (version) VALUES ('20120920185254');

INSERT INTO schema_migrations (version) VALUES ('20120920190225');

INSERT INTO schema_migrations (version) VALUES ('20120921215945');

INSERT INTO schema_migrations (version) VALUES ('20120926001753');

INSERT INTO schema_migrations (version) VALUES ('20120926205329');

INSERT INTO schema_migrations (version) VALUES ('20120927140530');

INSERT INTO schema_migrations (version) VALUES ('20120927162627');

INSERT INTO schema_migrations (version) VALUES ('20120927233328');

INSERT INTO schema_migrations (version) VALUES ('20121001233431');

INSERT INTO schema_migrations (version) VALUES ('20121002182701');

INSERT INTO schema_migrations (version) VALUES ('20121002221408');

INSERT INTO schema_migrations (version) VALUES ('20121003000827');

INSERT INTO schema_migrations (version) VALUES ('20121011190346');

INSERT INTO schema_migrations (version) VALUES ('20121015062339');

INSERT INTO schema_migrations (version) VALUES ('20121015063528');

INSERT INTO schema_migrations (version) VALUES ('20121015162626');

INSERT INTO schema_migrations (version) VALUES ('20121015234754');

INSERT INTO schema_migrations (version) VALUES ('20121018155541');

INSERT INTO schema_migrations (version) VALUES ('20121022161905');

INSERT INTO schema_migrations (version) VALUES ('20121022164136');

INSERT INTO schema_migrations (version) VALUES ('20121022170037');

INSERT INTO schema_migrations (version) VALUES ('20121022170650');

INSERT INTO schema_migrations (version) VALUES ('20121023231233');

INSERT INTO schema_migrations (version) VALUES ('20121024224011');

INSERT INTO schema_migrations (version) VALUES ('20121025005941');

INSERT INTO schema_migrations (version) VALUES ('20121025201527');

INSERT INTO schema_migrations (version) VALUES ('20121025210703');

INSERT INTO schema_migrations (version) VALUES ('20121026202821');

INSERT INTO schema_migrations (version) VALUES ('20121030122745');

INSERT INTO schema_migrations (version) VALUES ('20121030211144');

INSERT INTO schema_migrations (version) VALUES ('20121030233635');

INSERT INTO schema_migrations (version) VALUES ('20121031170420');

INSERT INTO schema_migrations (version) VALUES ('20121031171218');

INSERT INTO schema_migrations (version) VALUES ('20121031173945');

INSERT INTO schema_migrations (version) VALUES ('20121031175014');

INSERT INTO schema_migrations (version) VALUES ('20121102232307');

INSERT INTO schema_migrations (version) VALUES ('20121105142320');

INSERT INTO schema_migrations (version) VALUES ('20121105205953');

INSERT INTO schema_migrations (version) VALUES ('20121106040636');

INSERT INTO schema_migrations (version) VALUES ('20121106233227');

INSERT INTO schema_migrations (version) VALUES ('20121107010026');

INSERT INTO schema_migrations (version) VALUES ('20121107011013');

INSERT INTO schema_migrations (version) VALUES ('20121109205210');

INSERT INTO schema_migrations (version) VALUES ('20121113004839');

INSERT INTO schema_migrations (version) VALUES ('20121113014454');

INSERT INTO schema_migrations (version) VALUES ('20121113162840');

INSERT INTO schema_migrations (version) VALUES ('20121113235442');

INSERT INTO schema_migrations (version) VALUES ('20121120194816');

INSERT INTO schema_migrations (version) VALUES ('20121120233230');

INSERT INTO schema_migrations (version) VALUES ('20121127030436');

INSERT INTO schema_migrations (version) VALUES ('20121127220649');

INSERT INTO schema_migrations (version) VALUES ('20121127235434');

INSERT INTO schema_migrations (version) VALUES ('20121128024106');

INSERT INTO schema_migrations (version) VALUES ('20121128190857');

INSERT INTO schema_migrations (version) VALUES ('20121204002046');

INSERT INTO schema_migrations (version) VALUES ('20121211205004');

INSERT INTO schema_migrations (version) VALUES ('20121213192224');

INSERT INTO schema_migrations (version) VALUES ('20121213201052');

INSERT INTO schema_migrations (version) VALUES ('20121217192538');

INSERT INTO schema_migrations (version) VALUES ('20121218201910');

INSERT INTO schema_migrations (version) VALUES ('20121219013106');

INSERT INTO schema_migrations (version) VALUES ('20121219014619');

INSERT INTO schema_migrations (version) VALUES ('20121219075629');

INSERT INTO schema_migrations (version) VALUES ('20121221000840');

INSERT INTO schema_migrations (version) VALUES ('20130107203751');

INSERT INTO schema_migrations (version) VALUES ('20130107210307');

INSERT INTO schema_migrations (version) VALUES ('20130108230227');

INSERT INTO schema_migrations (version) VALUES ('20130109001539');

INSERT INTO schema_migrations (version) VALUES ('20130109012656');

INSERT INTO schema_migrations (version) VALUES ('20130109030908');

INSERT INTO schema_migrations (version) VALUES ('20130109191628');

INSERT INTO schema_migrations (version) VALUES ('20130110002316');

INSERT INTO schema_migrations (version) VALUES ('20130110144750');

INSERT INTO schema_migrations (version) VALUES ('20130110224657');

INSERT INTO schema_migrations (version) VALUES ('20130111185516');

INSERT INTO schema_migrations (version) VALUES ('20130111190446');

INSERT INTO schema_migrations (version) VALUES ('20130111191829');

INSERT INTO schema_migrations (version) VALUES ('20130115104434');

INSERT INTO schema_migrations (version) VALUES ('20130116201633');

INSERT INTO schema_migrations (version) VALUES ('20130117202158');

INSERT INTO schema_migrations (version) VALUES ('20130121122130');

INSERT INTO schema_migrations (version) VALUES ('20130122222557');

INSERT INTO schema_migrations (version) VALUES ('20130125192330');

INSERT INTO schema_migrations (version) VALUES ('20130128211741');

INSERT INTO schema_migrations (version) VALUES ('20130131220032');

INSERT INTO schema_migrations (version) VALUES ('20130201031839');

INSERT INTO schema_migrations (version) VALUES ('20130201210309');

INSERT INTO schema_migrations (version) VALUES ('20130205230537');

INSERT INTO schema_migrations (version) VALUES ('20130207011215');

INSERT INTO schema_migrations (version) VALUES ('20130209155423');

INSERT INTO schema_migrations (version) VALUES ('20130211155723');

INSERT INTO schema_migrations (version) VALUES ('20130211162448');

INSERT INTO schema_migrations (version) VALUES ('20130211185431');

INSERT INTO schema_migrations (version) VALUES ('20130211185741');

INSERT INTO schema_migrations (version) VALUES ('20130212010808');

INSERT INTO schema_migrations (version) VALUES ('20130213153443');

INSERT INTO schema_migrations (version) VALUES ('20130213162854');

INSERT INTO schema_migrations (version) VALUES ('20130213231743');

INSERT INTO schema_migrations (version) VALUES ('20130214205808');

INSERT INTO schema_migrations (version) VALUES ('20130214212029');

INSERT INTO schema_migrations (version) VALUES ('20130215162302');

INSERT INTO schema_migrations (version) VALUES ('20130215165052');

INSERT INTO schema_migrations (version) VALUES ('20130219212056');

INSERT INTO schema_migrations (version) VALUES ('20130220015651');

INSERT INTO schema_migrations (version) VALUES ('20130220180010');

INSERT INTO schema_migrations (version) VALUES ('20130223003239');

INSERT INTO schema_migrations (version) VALUES ('20130225235958');

INSERT INTO schema_migrations (version) VALUES ('20130226205925');

INSERT INTO schema_migrations (version) VALUES ('20130226220624');

INSERT INTO schema_migrations (version) VALUES ('20130226234043');

INSERT INTO schema_migrations (version) VALUES ('20130227220245');

INSERT INTO schema_migrations (version) VALUES ('20130228002622');

INSERT INTO schema_migrations (version) VALUES ('20130228231006');

INSERT INTO schema_migrations (version) VALUES ('20130228235319');

INSERT INTO schema_migrations (version) VALUES ('20130301012135');

INSERT INTO schema_migrations (version) VALUES ('20130301173215');

INSERT INTO schema_migrations (version) VALUES ('20130304190544');

INSERT INTO schema_migrations (version) VALUES ('20130304210432');

INSERT INTO schema_migrations (version) VALUES ('20130304230801');

INSERT INTO schema_migrations (version) VALUES ('20130306004109');

INSERT INTO schema_migrations (version) VALUES ('20130306213131');

INSERT INTO schema_migrations (version) VALUES ('20130307170035');

INSERT INTO schema_migrations (version) VALUES ('20130308212955');

INSERT INTO schema_migrations (version) VALUES ('20130311191535');

INSERT INTO schema_migrations (version) VALUES ('20130312182338');

INSERT INTO schema_migrations (version) VALUES ('20130312225815');

INSERT INTO schema_migrations (version) VALUES ('20130314191510');

INSERT INTO schema_migrations (version) VALUES ('20130318232819');

INSERT INTO schema_migrations (version) VALUES ('20130320003524');

INSERT INTO schema_migrations (version) VALUES ('20130320234214');

INSERT INTO schema_migrations (version) VALUES ('20130321150444');

INSERT INTO schema_migrations (version) VALUES ('20130321193711');

INSERT INTO schema_migrations (version) VALUES ('20130322020944');

INSERT INTO schema_migrations (version) VALUES ('20130327213459');

INSERT INTO schema_migrations (version) VALUES ('20130329233727');

INSERT INTO schema_migrations (version) VALUES ('20130403215032');

INSERT INTO schema_migrations (version) VALUES ('20130403230550');

INSERT INTO schema_migrations (version) VALUES ('20130403231829');

INSERT INTO schema_migrations (version) VALUES ('20130404181109');

INSERT INTO schema_migrations (version) VALUES ('20130404224208');

INSERT INTO schema_migrations (version) VALUES ('20130405222414');

INSERT INTO schema_migrations (version) VALUES ('20130406191548');

INSERT INTO schema_migrations (version) VALUES ('20130410005304');

INSERT INTO schema_migrations (version) VALUES ('20130410202446');

INSERT INTO schema_migrations (version) VALUES ('20130411185102');

INSERT INTO schema_migrations (version) VALUES ('20130415194701');

INSERT INTO schema_migrations (version) VALUES ('20130417004824');

INSERT INTO schema_migrations (version) VALUES ('20130417233520');

INSERT INTO schema_migrations (version) VALUES ('20130419195333');

INSERT INTO schema_migrations (version) VALUES ('20130423213650');

INSERT INTO schema_migrations (version) VALUES ('20130425003609');

INSERT INTO schema_migrations (version) VALUES ('20130425203153');

INSERT INTO schema_migrations (version) VALUES ('20130426215149');

INSERT INTO schema_migrations (version) VALUES ('20130430193150');

INSERT INTO schema_migrations (version) VALUES ('20130501230806');

INSERT INTO schema_migrations (version) VALUES ('20130502183154');

INSERT INTO schema_migrations (version) VALUES ('20130509195844');

INSERT INTO schema_migrations (version) VALUES ('20130509204356');

INSERT INTO schema_migrations (version) VALUES ('20130509204417');

INSERT INTO schema_migrations (version) VALUES ('20130510225945');

INSERT INTO schema_migrations (version) VALUES ('20130513214053');

INSERT INTO schema_migrations (version) VALUES ('20130514225222');

INSERT INTO schema_migrations (version) VALUES ('20130515194402');

INSERT INTO schema_migrations (version) VALUES ('20130516180139');

INSERT INTO schema_migrations (version) VALUES ('20130516222714');

INSERT INTO schema_migrations (version) VALUES ('20130520225123');

INSERT INTO schema_migrations (version) VALUES ('20130521002440');

INSERT INTO schema_migrations (version) VALUES ('20130521202509');

INSERT INTO schema_migrations (version) VALUES ('20130523211137');

INSERT INTO schema_migrations (version) VALUES ('20130523230117');

INSERT INTO schema_migrations (version) VALUES ('20130529211134');

INSERT INTO schema_migrations (version) VALUES ('20130603180539');

INSERT INTO schema_migrations (version) VALUES ('20130605021356');

INSERT INTO schema_migrations (version) VALUES ('20130607180008');

INSERT INTO schema_migrations (version) VALUES ('20130614000205');

INSERT INTO schema_migrations (version) VALUES ('20130615000558');

INSERT INTO schema_migrations (version) VALUES ('20130618200915');

INSERT INTO schema_migrations (version) VALUES ('20130618232733');

INSERT INTO schema_migrations (version) VALUES ('20130619001735');

INSERT INTO schema_migrations (version) VALUES ('20130619212813');

INSERT INTO schema_migrations (version) VALUES ('20130619212926');

INSERT INTO schema_migrations (version) VALUES ('20130620211301');

INSERT INTO schema_migrations (version) VALUES ('20130621180123');

INSERT INTO schema_migrations (version) VALUES ('20130622000537');

INSERT INTO schema_migrations (version) VALUES ('20130624200059');

INSERT INTO schema_migrations (version) VALUES ('20130627002927');

INSERT INTO schema_migrations (version) VALUES ('20130628195118');

INSERT INTO schema_migrations (version) VALUES ('20130701203533');

INSERT INTO schema_migrations (version) VALUES ('20130703170955');

INSERT INTO schema_migrations (version) VALUES ('20130708185320');

INSERT INTO schema_migrations (version) VALUES ('20130709003130');

INSERT INTO schema_migrations (version) VALUES ('20130711202057');

INSERT INTO schema_migrations (version) VALUES ('20130711230224');

INSERT INTO schema_migrations (version) VALUES ('20130715215547');

INSERT INTO schema_migrations (version) VALUES ('20130716180926');

INSERT INTO schema_migrations (version) VALUES ('20130716195532');

INSERT INTO schema_migrations (version) VALUES ('20130716210237');

INSERT INTO schema_migrations (version) VALUES ('20130719222826');

INSERT INTO schema_migrations (version) VALUES ('20130723151134');

INSERT INTO schema_migrations (version) VALUES ('20130723153830');

INSERT INTO schema_migrations (version) VALUES ('20130726010102');

INSERT INTO schema_migrations (version) VALUES ('20130731211358');

INSERT INTO schema_migrations (version) VALUES ('20130731235816');

INSERT INTO schema_migrations (version) VALUES ('20130801224914');

INSERT INTO schema_migrations (version) VALUES ('20130805212852');

INSERT INTO schema_migrations (version) VALUES ('20130806215542');

INSERT INTO schema_migrations (version) VALUES ('20130806223041');

INSERT INTO schema_migrations (version) VALUES ('20130806223107');

INSERT INTO schema_migrations (version) VALUES ('20130809230105');

INSERT INTO schema_migrations (version) VALUES ('20130820215723');

INSERT INTO schema_migrations (version) VALUES ('20130821225958');

INSERT INTO schema_migrations (version) VALUES ('20130903202100');

INSERT INTO schema_migrations (version) VALUES ('20130906174415');

INSERT INTO schema_migrations (version) VALUES ('20130907183452');

INSERT INTO schema_migrations (version) VALUES ('20130907183911');

INSERT INTO schema_migrations (version) VALUES ('20130907184228');

INSERT INTO schema_migrations (version) VALUES ('20130909233157');

INSERT INTO schema_migrations (version) VALUES ('20130910194629');

INSERT INTO schema_migrations (version) VALUES ('20130911222343');

INSERT INTO schema_migrations (version) VALUES ('20130913005023');

INSERT INTO schema_migrations (version) VALUES ('20130913112305');

INSERT INTO schema_migrations (version) VALUES ('20130913205228');

INSERT INTO schema_migrations (version) VALUES ('20130913213438');

INSERT INTO schema_migrations (version) VALUES ('20130917000459');

INSERT INTO schema_migrations (version) VALUES ('20130917003600');

INSERT INTO schema_migrations (version) VALUES ('20130918005041');

INSERT INTO schema_migrations (version) VALUES ('20130918190550');

INSERT INTO schema_migrations (version) VALUES ('20130920002651');

INSERT INTO schema_migrations (version) VALUES ('20130920181734');

INSERT INTO schema_migrations (version) VALUES ('20130920183303');

INSERT INTO schema_migrations (version) VALUES ('20130920214215');

INSERT INTO schema_migrations (version) VALUES ('20130925222046');

INSERT INTO schema_migrations (version) VALUES ('20130925222049');

INSERT INTO schema_migrations (version) VALUES ('20130926182801');

INSERT INTO schema_migrations (version) VALUES ('20130926222553');

INSERT INTO schema_migrations (version) VALUES ('20130927001700');

INSERT INTO schema_migrations (version) VALUES ('20130927160717');

INSERT INTO schema_migrations (version) VALUES ('20130928165528');

INSERT INTO schema_migrations (version) VALUES ('20130930180623');

INSERT INTO schema_migrations (version) VALUES ('20130930204154');

INSERT INTO schema_migrations (version) VALUES ('20131001182453');

INSERT INTO schema_migrations (version) VALUES ('20131003001920');

INSERT INTO schema_migrations (version) VALUES ('20131007023838');

INSERT INTO schema_migrations (version) VALUES ('20131011004502');

INSERT INTO schema_migrations (version) VALUES ('20131012005514');

INSERT INTO schema_migrations (version) VALUES ('20131014213855');

INSERT INTO schema_migrations (version) VALUES ('20131015010802');

INSERT INTO schema_migrations (version) VALUES ('20131016234356');

INSERT INTO schema_migrations (version) VALUES ('20131016234907');

INSERT INTO schema_migrations (version) VALUES ('20131016235827');

INSERT INTO schema_migrations (version) VALUES ('20131018191520');

INSERT INTO schema_migrations (version) VALUES ('20131018211748');

INSERT INTO schema_migrations (version) VALUES ('20131021142559');

INSERT INTO schema_migrations (version) VALUES ('20131022005459');

INSERT INTO schema_migrations (version) VALUES ('20131022184025');

INSERT INTO schema_migrations (version) VALUES ('20131023200318');

INSERT INTO schema_migrations (version) VALUES ('20131024111405');

INSERT INTO schema_migrations (version) VALUES ('20131030000359');

INSERT INTO schema_migrations (version) VALUES ('20131030212219');

INSERT INTO schema_migrations (version) VALUES ('20131111213444');

INSERT INTO schema_migrations (version) VALUES ('20131112175718');

INSERT INTO schema_migrations (version) VALUES ('20131114000435');

INSERT INTO schema_migrations (version) VALUES ('20131114194645');

INSERT INTO schema_migrations (version) VALUES ('20131114235605');

INSERT INTO schema_migrations (version) VALUES ('20131121194630');

INSERT INTO schema_migrations (version) VALUES ('20131121230231');

INSERT INTO schema_migrations (version) VALUES ('20131122002324');

INSERT INTO schema_migrations (version) VALUES ('20131122233455');

INSERT INTO schema_migrations (version) VALUES ('20131123013325');

INSERT INTO schema_migrations (version) VALUES ('20131202193450');

INSERT INTO schema_migrations (version) VALUES ('20131203181455');

INSERT INTO schema_migrations (version) VALUES ('20131203190514');

INSERT INTO schema_migrations (version) VALUES ('20131209235932');

INSERT INTO schema_migrations (version) VALUES ('20131210005417');

INSERT INTO schema_migrations (version) VALUES ('20131210011501');

INSERT INTO schema_migrations (version) VALUES ('20131210013518');

INSERT INTO schema_migrations (version) VALUES ('20131211212934');

INSERT INTO schema_migrations (version) VALUES ('20131212192044');

INSERT INTO schema_migrations (version) VALUES ('20131212195208');

INSERT INTO schema_migrations (version) VALUES ('20131212203103');

INSERT INTO schema_migrations (version) VALUES ('20131217210009');

INSERT INTO schema_migrations (version) VALUES ('20131217210706');

INSERT INTO schema_migrations (version) VALUES ('20131218001528');

INSERT INTO schema_migrations (version) VALUES ('20131219111203');

INSERT INTO schema_migrations (version) VALUES ('20131220004716');

INSERT INTO schema_migrations (version) VALUES ('20131230210113');

INSERT INTO schema_migrations (version) VALUES ('20131230210201');

INSERT INTO schema_migrations (version) VALUES ('20131230210451');

INSERT INTO schema_migrations (version) VALUES ('20140106200246');

INSERT INTO schema_migrations (version) VALUES ('20140106200292');

INSERT INTO schema_migrations (version) VALUES ('20140106214915');

INSERT INTO schema_migrations (version) VALUES ('20140107015957');

INSERT INTO schema_migrations (version) VALUES ('20140107124458');

INSERT INTO schema_migrations (version) VALUES ('20140107124498');

INSERT INTO schema_migrations (version) VALUES ('20140107200729');

INSERT INTO schema_migrations (version) VALUES ('20140108192040');

INSERT INTO schema_migrations (version) VALUES ('20140109000507');

INSERT INTO schema_migrations (version) VALUES ('20140109000535');

INSERT INTO schema_migrations (version) VALUES ('20140109000590');

INSERT INTO schema_migrations (version) VALUES ('20140109003128');

INSERT INTO schema_migrations (version) VALUES ('20140109005149');

INSERT INTO schema_migrations (version) VALUES ('20140110200715');

INSERT INTO schema_migrations (version) VALUES ('20140113204102');

INSERT INTO schema_migrations (version) VALUES ('20140114000016');

INSERT INTO schema_migrations (version) VALUES ('20140114003808');

INSERT INTO schema_migrations (version) VALUES ('20140114224024');

INSERT INTO schema_migrations (version) VALUES ('20140115202216');

INSERT INTO schema_migrations (version) VALUES ('20140115202296');

INSERT INTO schema_migrations (version) VALUES ('20140115202299');

INSERT INTO schema_migrations (version) VALUES ('20140122002242');

INSERT INTO schema_migrations (version) VALUES ('20140123222919');

INSERT INTO schema_migrations (version) VALUES ('20140124035609');

INSERT INTO schema_migrations (version) VALUES ('20140124160736');

INSERT INTO schema_migrations (version) VALUES ('20140124190824');

INSERT INTO schema_migrations (version) VALUES ('20140124200830');

INSERT INTO schema_migrations (version) VALUES ('20140127113600');

INSERT INTO schema_migrations (version) VALUES ('20140127234112');

INSERT INTO schema_migrations (version) VALUES ('20140130173344');

INSERT INTO schema_migrations (version) VALUES ('20140130204438');

INSERT INTO schema_migrations (version) VALUES ('20140131195735');

INSERT INTO schema_migrations (version) VALUES ('20140201003547');

INSERT INTO schema_migrations (version) VALUES ('20140205194433');

INSERT INTO schema_migrations (version) VALUES ('20140205220751');

INSERT INTO schema_migrations (version) VALUES ('20140205220799');

INSERT INTO schema_migrations (version) VALUES ('20140212195927');

INSERT INTO schema_migrations (version) VALUES ('20140214103600');

INSERT INTO schema_migrations (version) VALUES ('20140221010032');

INSERT INTO schema_migrations (version) VALUES ('20140221112442');

INSERT INTO schema_migrations (version) VALUES ('20140221213852');

INSERT INTO schema_migrations (version) VALUES ('20140221222906');

INSERT INTO schema_migrations (version) VALUES ('20140221223713');

INSERT INTO schema_migrations (version) VALUES ('20140224191137');

INSERT INTO schema_migrations (version) VALUES ('20140224214010');

INSERT INTO schema_migrations (version) VALUES ('20140224220513');

INSERT INTO schema_migrations (version) VALUES ('20140224221112');

INSERT INTO schema_migrations (version) VALUES ('20140224221624');

INSERT INTO schema_migrations (version) VALUES ('20140225022352');

INSERT INTO schema_migrations (version) VALUES ('20140225183201');

INSERT INTO schema_migrations (version) VALUES ('20140225213139');

INSERT INTO schema_migrations (version) VALUES ('20140227005751');

INSERT INTO schema_migrations (version) VALUES ('20140303194507');

INSERT INTO schema_migrations (version) VALUES ('20140303195228');

INSERT INTO schema_migrations (version) VALUES ('20140305231327');

INSERT INTO schema_migrations (version) VALUES ('20140312172903');

INSERT INTO schema_migrations (version) VALUES ('20140312204638');

INSERT INTO schema_migrations (version) VALUES ('20140313185445');

INSERT INTO schema_migrations (version) VALUES ('20140314013037');

INSERT INTO schema_migrations (version) VALUES ('20140314182438');

INSERT INTO schema_migrations (version) VALUES ('20140314182498');

INSERT INTO schema_migrations (version) VALUES ('20140314213306');

INSERT INTO schema_migrations (version) VALUES ('20140314213731');

INSERT INTO schema_migrations (version) VALUES ('20140317213817');

INSERT INTO schema_migrations (version) VALUES ('20140319130602');

INSERT INTO schema_migrations (version) VALUES ('20140321194055');

INSERT INTO schema_migrations (version) VALUES ('20140321194302');

INSERT INTO schema_migrations (version) VALUES ('20140323192456');

INSERT INTO schema_migrations (version) VALUES ('20140324170311');

INSERT INTO schema_migrations (version) VALUES ('20140324214819');

INSERT INTO schema_migrations (version) VALUES ('20140324220026');

INSERT INTO schema_migrations (version) VALUES ('20140324221005');

INSERT INTO schema_migrations (version) VALUES ('20140326000337');

INSERT INTO schema_migrations (version) VALUES ('20140327195940');

INSERT INTO schema_migrations (version) VALUES ('20140327215825');

INSERT INTO schema_migrations (version) VALUES ('20140328161828');

INSERT INTO schema_migrations (version) VALUES ('20140328161839');

INSERT INTO schema_migrations (version) VALUES ('20140403001651');

INSERT INTO schema_migrations (version) VALUES ('20140403003526');

INSERT INTO schema_migrations (version) VALUES ('20140403190505');

INSERT INTO schema_migrations (version) VALUES ('20140403190635');

INSERT INTO schema_migrations (version) VALUES ('20140403192920');

INSERT INTO schema_migrations (version) VALUES ('20140403193210');

INSERT INTO schema_migrations (version) VALUES ('20140403202822');

INSERT INTO schema_migrations (version) VALUES ('20140403233305');

INSERT INTO schema_migrations (version) VALUES ('20140404192126');

INSERT INTO schema_migrations (version) VALUES ('20140407212414');

INSERT INTO schema_migrations (version) VALUES ('20140407235002');

INSERT INTO schema_migrations (version) VALUES ('20140409215957');

INSERT INTO schema_migrations (version) VALUES ('20140411200741');

INSERT INTO schema_migrations (version) VALUES ('20140415184522');

INSERT INTO schema_migrations (version) VALUES ('20140415185145');

INSERT INTO schema_migrations (version) VALUES ('20140421110102');

INSERT INTO schema_migrations (version) VALUES ('20140421202344');

INSERT INTO schema_migrations (version) VALUES ('20140422184141');

INSERT INTO schema_migrations (version) VALUES ('20140422212449');

INSERT INTO schema_migrations (version) VALUES ('20140424140433');

INSERT INTO schema_migrations (version) VALUES ('20140424145625');

INSERT INTO schema_migrations (version) VALUES ('20140424150307');

INSERT INTO schema_migrations (version) VALUES ('20140428215203');

INSERT INTO schema_migrations (version) VALUES ('20140428215548');

INSERT INTO schema_migrations (version) VALUES ('20140429043737');

INSERT INTO schema_migrations (version) VALUES ('20140505163104');

INSERT INTO schema_migrations (version) VALUES ('20140505232621');

INSERT INTO schema_migrations (version) VALUES ('20140506212459');

INSERT INTO schema_migrations (version) VALUES ('20140508192404');

INSERT INTO schema_migrations (version) VALUES ('20140508200255');

INSERT INTO schema_migrations (version) VALUES ('20140508232629');

INSERT INTO schema_migrations (version) VALUES ('20140509131204');

INSERT INTO schema_migrations (version) VALUES ('20140513135143');

INSERT INTO schema_migrations (version) VALUES ('20140513161204');

INSERT INTO schema_migrations (version) VALUES ('20140513164704');

INSERT INTO schema_migrations (version) VALUES ('20140514001655');

INSERT INTO schema_migrations (version) VALUES ('20140514043050');

INSERT INTO schema_migrations (version) VALUES ('20140514163317');

INSERT INTO schema_migrations (version) VALUES ('20140514174743');

INSERT INTO schema_migrations (version) VALUES ('20140514203304');

INSERT INTO schema_migrations (version) VALUES ('20140514223251');

INSERT INTO schema_migrations (version) VALUES ('20140515012947');

INSERT INTO schema_migrations (version) VALUES ('20140515165451');

INSERT INTO schema_migrations (version) VALUES ('20140515165459');

INSERT INTO schema_migrations (version) VALUES ('20140515220932');

INSERT INTO schema_migrations (version) VALUES ('20140516195210');

INSERT INTO schema_migrations (version) VALUES ('20140517052802');

INSERT INTO schema_migrations (version) VALUES ('20140517164352');

INSERT INTO schema_migrations (version) VALUES ('20140517165722');

INSERT INTO schema_migrations (version) VALUES ('20140517170812');

INSERT INTO schema_migrations (version) VALUES ('20140517172243');

INSERT INTO schema_migrations (version) VALUES ('20140517230645');

INSERT INTO schema_migrations (version) VALUES ('20140518021101');

INSERT INTO schema_migrations (version) VALUES ('20140518021701');

INSERT INTO schema_migrations (version) VALUES ('20140518022626');

INSERT INTO schema_migrations (version) VALUES ('20140521190240');

INSERT INTO schema_migrations (version) VALUES ('20140521190247');

INSERT INTO schema_migrations (version) VALUES ('20140521211747');

INSERT INTO schema_migrations (version) VALUES ('20140521221751');

INSERT INTO schema_migrations (version) VALUES ('20140522160042');

INSERT INTO schema_migrations (version) VALUES ('20140522165640');

INSERT INTO schema_migrations (version) VALUES ('20140522175959');

INSERT INTO schema_migrations (version) VALUES ('20140522182008');

INSERT INTO schema_migrations (version) VALUES ('20140522675959');

INSERT INTO schema_migrations (version) VALUES ('20140527192153');

INSERT INTO schema_migrations (version) VALUES ('20140528212803');

INSERT INTO schema_migrations (version) VALUES ('20140602164002');

INSERT INTO schema_migrations (version) VALUES ('20140603175217');

INSERT INTO schema_migrations (version) VALUES ('20140603195317');

INSERT INTO schema_migrations (version) VALUES ('20140603223607');

INSERT INTO schema_migrations (version) VALUES ('20140604053336');

INSERT INTO schema_migrations (version) VALUES ('20140605030144');

INSERT INTO schema_migrations (version) VALUES ('20140605102002');

INSERT INTO schema_migrations (version) VALUES ('20140605182422');

INSERT INTO schema_migrations (version) VALUES ('20140605221507');

INSERT INTO schema_migrations (version) VALUES ('20140609232011');

INSERT INTO schema_migrations (version) VALUES ('20140610230521');

INSERT INTO schema_migrations (version) VALUES ('20140611123002');

INSERT INTO schema_migrations (version) VALUES ('20140611203126');

INSERT INTO schema_migrations (version) VALUES ('20140611203139');

INSERT INTO schema_migrations (version) VALUES ('20140611203147');

INSERT INTO schema_migrations (version) VALUES ('20140611223504');

INSERT INTO schema_migrations (version) VALUES ('20140611235747');

INSERT INTO schema_migrations (version) VALUES ('20140612205218');

INSERT INTO schema_migrations (version) VALUES ('20140613231614');

INSERT INTO schema_migrations (version) VALUES ('20140614013429');

INSERT INTO schema_migrations (version) VALUES ('20140616151612');

INSERT INTO schema_migrations (version) VALUES ('20140616155258');

INSERT INTO schema_migrations (version) VALUES ('20140616155931');

INSERT INTO schema_migrations (version) VALUES ('20140616220408');

INSERT INTO schema_migrations (version) VALUES ('20140616223736');

INSERT INTO schema_migrations (version) VALUES ('20140616233150');

INSERT INTO schema_migrations (version) VALUES ('20140618171348');

INSERT INTO schema_migrations (version) VALUES ('20140618171505');

INSERT INTO schema_migrations (version) VALUES ('20140618171847');

INSERT INTO schema_migrations (version) VALUES ('20140618184223');

INSERT INTO schema_migrations (version) VALUES ('20140618214636');

INSERT INTO schema_migrations (version) VALUES ('20140619195210');

INSERT INTO schema_migrations (version) VALUES ('20140619200149');

INSERT INTO schema_migrations (version) VALUES ('20140619212954');

INSERT INTO schema_migrations (version) VALUES ('20140619222411');

INSERT INTO schema_migrations (version) VALUES ('20140620214005');

INSERT INTO schema_migrations (version) VALUES ('20140621005008');

INSERT INTO schema_migrations (version) VALUES ('20140622112853');

INSERT INTO schema_migrations (version) VALUES ('20140623184021');

INSERT INTO schema_migrations (version) VALUES ('20140623184022');

INSERT INTO schema_migrations (version) VALUES ('20140623212344');

INSERT INTO schema_migrations (version) VALUES ('20140624171602');

INSERT INTO schema_migrations (version) VALUES ('20140624221803');

INSERT INTO schema_migrations (version) VALUES ('20140625180348');

INSERT INTO schema_migrations (version) VALUES ('20140625221807');

INSERT INTO schema_migrations (version) VALUES ('20140625221808');

INSERT INTO schema_migrations (version) VALUES ('20140627002920');

INSERT INTO schema_migrations (version) VALUES ('20140627211602');

INSERT INTO schema_migrations (version) VALUES ('20140630185359');

INSERT INTO schema_migrations (version) VALUES ('20140702205631');

INSERT INTO schema_migrations (version) VALUES ('20140703201956');

INSERT INTO schema_migrations (version) VALUES ('20140703223033');

INSERT INTO schema_migrations (version) VALUES ('20140703234826');

INSERT INTO schema_migrations (version) VALUES ('20140710174534');

INSERT INTO schema_migrations (version) VALUES ('20140710181737');

INSERT INTO schema_migrations (version) VALUES ('20140711185211');

INSERT INTO schema_migrations (version) VALUES ('20140715213844');

INSERT INTO schema_migrations (version) VALUES ('20140716194524');

INSERT INTO schema_migrations (version) VALUES ('20140717001015');

INSERT INTO schema_migrations (version) VALUES ('20140717001019');

INSERT INTO schema_migrations (version) VALUES ('20140718064612');

INSERT INTO schema_migrations (version) VALUES ('20140718190148');

INSERT INTO schema_migrations (version) VALUES ('20140721181004');

INSERT INTO schema_migrations (version) VALUES ('20140721223257');

INSERT INTO schema_migrations (version) VALUES ('20140721223310');

INSERT INTO schema_migrations (version) VALUES ('20140722184524');

INSERT INTO schema_migrations (version) VALUES ('20140722211555');

INSERT INTO schema_migrations (version) VALUES ('20140728220702');

INSERT INTO schema_migrations (version) VALUES ('20140729184629');

INSERT INTO schema_migrations (version) VALUES ('20140729185509');

INSERT INTO schema_migrations (version) VALUES ('20140729185919');

INSERT INTO schema_migrations (version) VALUES ('20140729200938');

INSERT INTO schema_migrations (version) VALUES ('20140729201611');

INSERT INTO schema_migrations (version) VALUES ('20140730025805');

INSERT INTO schema_migrations (version) VALUES ('20140730224917');

INSERT INTO schema_migrations (version) VALUES ('20140730234444');

INSERT INTO schema_migrations (version) VALUES ('20140731001528');

INSERT INTO schema_migrations (version) VALUES ('20140731211759');

INSERT INTO schema_migrations (version) VALUES ('20140801234136');

INSERT INTO schema_migrations (version) VALUES ('20140803105500');

INSERT INTO schema_migrations (version) VALUES ('20140803203034');

INSERT INTO schema_migrations (version) VALUES ('20140805171114');

INSERT INTO schema_migrations (version) VALUES ('20140805191045');

INSERT INTO schema_migrations (version) VALUES ('20140805192857');

INSERT INTO schema_migrations (version) VALUES ('20140805194827');

INSERT INTO schema_migrations (version) VALUES ('20140805204031');

INSERT INTO schema_migrations (version) VALUES ('20140805204229');

INSERT INTO schema_migrations (version) VALUES ('20140808214518');

INSERT INTO schema_migrations (version) VALUES ('20140808235144');

INSERT INTO schema_migrations (version) VALUES ('20140811182617');

INSERT INTO schema_migrations (version) VALUES ('20140811202031');

INSERT INTO schema_migrations (version) VALUES ('20140811223828');

INSERT INTO schema_migrations (version) VALUES ('20140814205539');

INSERT INTO schema_migrations (version) VALUES ('20140815002106');

INSERT INTO schema_migrations (version) VALUES ('20140819171404');

INSERT INTO schema_migrations (version) VALUES ('20140819183502');

INSERT INTO schema_migrations (version) VALUES ('20140819214400');

INSERT INTO schema_migrations (version) VALUES ('20140820021212');

INSERT INTO schema_migrations (version) VALUES ('20140820201259');

INSERT INTO schema_migrations (version) VALUES ('20140822201450');

INSERT INTO schema_migrations (version) VALUES ('20140826211745');

INSERT INTO schema_migrations (version) VALUES ('20140828003342');

INSERT INTO schema_migrations (version) VALUES ('20140831221919');

INSERT INTO schema_migrations (version) VALUES ('20140902213101');

INSERT INTO schema_migrations (version) VALUES ('20140902213436');

INSERT INTO schema_migrations (version) VALUES ('20140902220219');

INSERT INTO schema_migrations (version) VALUES ('20140903182814');

INSERT INTO schema_migrations (version) VALUES ('20140903203439');

INSERT INTO schema_migrations (version) VALUES ('20140904200048');

INSERT INTO schema_migrations (version) VALUES ('20140905184820');

INSERT INTO schema_migrations (version) VALUES ('20140908184820');

INSERT INTO schema_migrations (version) VALUES ('20140908210532');

INSERT INTO schema_migrations (version) VALUES ('20140908210533');

INSERT INTO schema_migrations (version) VALUES ('20140908210534');

INSERT INTO schema_migrations (version) VALUES ('20140909184820');

INSERT INTO schema_migrations (version) VALUES ('20140912030521');

INSERT INTO schema_migrations (version) VALUES ('20140915181620');

INSERT INTO schema_migrations (version) VALUES ('20140915181647');

INSERT INTO schema_migrations (version) VALUES ('20140915181717');

INSERT INTO schema_migrations (version) VALUES ('20140916003431');

INSERT INTO schema_migrations (version) VALUES ('20140916184614');

INSERT INTO schema_migrations (version) VALUES ('20140917015550');

INSERT INTO schema_migrations (version) VALUES ('20140917204254');

INSERT INTO schema_migrations (version) VALUES ('20140917232729');

INSERT INTO schema_migrations (version) VALUES ('20140924201448');

INSERT INTO schema_migrations (version) VALUES ('20140925232906');

INSERT INTO schema_migrations (version) VALUES ('20140926204907');

INSERT INTO schema_migrations (version) VALUES ('20140926213124');

INSERT INTO schema_migrations (version) VALUES ('20140926232527');

INSERT INTO schema_migrations (version) VALUES ('20140929183855');

INSERT INTO schema_migrations (version) VALUES ('20140929205318');

INSERT INTO schema_migrations (version) VALUES ('20140929212037');

INSERT INTO schema_migrations (version) VALUES ('20141007231019');

INSERT INTO schema_migrations (version) VALUES ('20141010002307');

INSERT INTO schema_migrations (version) VALUES ('20141013175520');

INSERT INTO schema_migrations (version) VALUES ('20141013180417');

INSERT INTO schema_migrations (version) VALUES ('20141014191306');

INSERT INTO schema_migrations (version) VALUES ('20141014213243');

INSERT INTO schema_migrations (version) VALUES ('20141014221425');

INSERT INTO schema_migrations (version) VALUES ('20141014221800');

INSERT INTO schema_migrations (version) VALUES ('20141015211436');

INSERT INTO schema_migrations (version) VALUES ('20141016151245');

INSERT INTO schema_migrations (version) VALUES ('20141016232527');

INSERT INTO schema_migrations (version) VALUES ('20141020192853');

INSERT INTO schema_migrations (version) VALUES ('20141020195658');

INSERT INTO schema_migrations (version) VALUES ('20141021185220');

INSERT INTO schema_migrations (version) VALUES ('20141021200534');

INSERT INTO schema_migrations (version) VALUES ('20141022000051');

INSERT INTO schema_migrations (version) VALUES ('20141024220712');

INSERT INTO schema_migrations (version) VALUES ('20141024223805');

INSERT INTO schema_migrations (version) VALUES ('20141024224159');

INSERT INTO schema_migrations (version) VALUES ('20141027180129');

INSERT INTO schema_migrations (version) VALUES ('20141028232541');

INSERT INTO schema_migrations (version) VALUES ('20141030003332');

INSERT INTO schema_migrations (version) VALUES ('20141030183448');

INSERT INTO schema_migrations (version) VALUES ('20141030220623');

INSERT INTO schema_migrations (version) VALUES ('20141104183058');

INSERT INTO schema_migrations (version) VALUES ('20141104192710');

INSERT INTO schema_migrations (version) VALUES ('20141104222731');

INSERT INTO schema_migrations (version) VALUES ('20141104230913');

INSERT INTO schema_migrations (version) VALUES ('20141105210713');

INSERT INTO schema_migrations (version) VALUES ('20141106181230');

INSERT INTO schema_migrations (version) VALUES ('20141106204528');

INSERT INTO schema_migrations (version) VALUES ('20141111002553');

INSERT INTO schema_migrations (version) VALUES ('20141112214816');

INSERT INTO schema_migrations (version) VALUES ('20141113193836');

INSERT INTO schema_migrations (version) VALUES ('20141113205205');

INSERT INTO schema_migrations (version) VALUES ('20141114200226');

INSERT INTO schema_migrations (version) VALUES ('20141114200322');

INSERT INTO schema_migrations (version) VALUES ('20141117183506');

INSERT INTO schema_migrations (version) VALUES ('20141118233251');

INSERT INTO schema_migrations (version) VALUES ('20141119194114');

INSERT INTO schema_migrations (version) VALUES ('20141120204818');

INSERT INTO schema_migrations (version) VALUES ('20141123160140');

INSERT INTO schema_migrations (version) VALUES ('20141125213037');

INSERT INTO schema_migrations (version) VALUES ('20141201190836');

INSERT INTO schema_migrations (version) VALUES ('20141201190840');

INSERT INTO schema_migrations (version) VALUES ('20141202035548');

INSERT INTO schema_migrations (version) VALUES ('20141202035558');

INSERT INTO schema_migrations (version) VALUES ('20141205031448');

INSERT INTO schema_migrations (version) VALUES ('20141205192639');

INSERT INTO schema_migrations (version) VALUES ('20141208204733');

INSERT INTO schema_migrations (version) VALUES ('20141208223115');

INSERT INTO schema_migrations (version) VALUES ('20141209192009');

INSERT INTO schema_migrations (version) VALUES ('20141209194504');

INSERT INTO schema_migrations (version) VALUES ('20141209194954');

INSERT INTO schema_migrations (version) VALUES ('20141210194718');

INSERT INTO schema_migrations (version) VALUES ('20141215213119');

INSERT INTO schema_migrations (version) VALUES ('20141217220024');

INSERT INTO schema_migrations (version) VALUES ('20141218223631');

INSERT INTO schema_migrations (version) VALUES ('20150109211220');

INSERT INTO schema_migrations (version) VALUES ('20150109214218');

INSERT INTO schema_migrations (version) VALUES ('20150111161651');

INSERT INTO schema_migrations (version) VALUES ('20150112175010');

INSERT INTO schema_migrations (version) VALUES ('20150116192652');

INSERT INTO schema_migrations (version) VALUES ('20150119210614');

INSERT INTO schema_migrations (version) VALUES ('20150120225151');

INSERT INTO schema_migrations (version) VALUES ('20150122011114');

INSERT INTO schema_migrations (version) VALUES ('20150126192843');

INSERT INTO schema_migrations (version) VALUES ('20150127211547');

INSERT INTO schema_migrations (version) VALUES ('20150129223552');

INSERT INTO schema_migrations (version) VALUES ('20150204001441');

INSERT INTO schema_migrations (version) VALUES ('20150206025051');

INSERT INTO schema_migrations (version) VALUES ('20150211003929');

INSERT INTO schema_migrations (version) VALUES ('20150211191606');

INSERT INTO schema_migrations (version) VALUES ('20150211225222');

INSERT INTO schema_migrations (version) VALUES ('20150212194140');

INSERT INTO schema_migrations (version) VALUES ('20150212194416');

INSERT INTO schema_migrations (version) VALUES ('20150212203827');

INSERT INTO schema_migrations (version) VALUES ('20150213000001');

INSERT INTO schema_migrations (version) VALUES ('20150218004425');

INSERT INTO schema_migrations (version) VALUES ('20150218154222');

INSERT INTO schema_migrations (version) VALUES ('20150218183347');

INSERT INTO schema_migrations (version) VALUES ('20150220164942');

INSERT INTO schema_migrations (version) VALUES ('20150225211523');

INSERT INTO schema_migrations (version) VALUES ('20150225222458');

INSERT INTO schema_migrations (version) VALUES ('20150226000001');

INSERT INTO schema_migrations (version) VALUES ('20150227000001');

INSERT INTO schema_migrations (version) VALUES ('20150227232543');

INSERT INTO schema_migrations (version) VALUES ('20150227232549');

INSERT INTO schema_migrations (version) VALUES ('20150303011858');

INSERT INTO schema_migrations (version) VALUES ('20150303014118');

INSERT INTO schema_migrations (version) VALUES ('20150304000001');

INSERT INTO schema_migrations (version) VALUES ('20150304000019');

INSERT INTO schema_migrations (version) VALUES ('20150305000001');

INSERT INTO schema_migrations (version) VALUES ('20150305192812');

INSERT INTO schema_migrations (version) VALUES ('20150306211346');

INSERT INTO schema_migrations (version) VALUES ('20150311000001');

INSERT INTO schema_migrations (version) VALUES ('20150313001812');

INSERT INTO schema_migrations (version) VALUES ('20150316202016');

INSERT INTO schema_migrations (version) VALUES ('20150316212206');

INSERT INTO schema_migrations (version) VALUES ('20150326000001');

INSERT INTO schema_migrations (version) VALUES ('20150326211253');

INSERT INTO schema_migrations (version) VALUES ('20150331002025');

INSERT INTO schema_migrations (version) VALUES ('20150331132932');

INSERT INTO schema_migrations (version) VALUES ('20150331203314');

INSERT INTO schema_migrations (version) VALUES ('20150403184900');

INSERT INTO schema_migrations (version) VALUES ('20150410160033');

INSERT INTO schema_migrations (version) VALUES ('20150413183042');

INSERT INTO schema_migrations (version) VALUES ('20150414132940');

INSERT INTO schema_migrations (version) VALUES ('20150416150541');

INSERT INTO schema_migrations (version) VALUES ('20150416183434');

INSERT INTO schema_migrations (version) VALUES ('20150417202325');

INSERT INTO schema_migrations (version) VALUES ('20150417203308');

INSERT INTO schema_migrations (version) VALUES ('20150420181623');

INSERT INTO schema_migrations (version) VALUES ('20150421184326');

INSERT INTO schema_migrations (version) VALUES ('20150422183717');

INSERT INTO schema_migrations (version) VALUES ('20150423171638');

INSERT INTO schema_migrations (version) VALUES ('20150423174511');

INSERT INTO schema_migrations (version) VALUES ('20150423175548');

INSERT INTO schema_migrations (version) VALUES ('20150423183024');

INSERT INTO schema_migrations (version) VALUES ('20150423736103');

INSERT INTO schema_migrations (version) VALUES ('20150424014345');

INSERT INTO schema_migrations (version) VALUES ('20150424044114');

INSERT INTO schema_migrations (version) VALUES ('20150424062923');

INSERT INTO schema_migrations (version) VALUES ('20150424155130');

INSERT INTO schema_migrations (version) VALUES ('20150424161710');

INSERT INTO schema_migrations (version) VALUES ('20150425194607');

INSERT INTO schema_migrations (version) VALUES ('20150425201718');

INSERT INTO schema_migrations (version) VALUES ('20150427191244');

INSERT INTO schema_migrations (version) VALUES ('20150427222314');

INSERT INTO schema_migrations (version) VALUES ('20150429010410');

INSERT INTO schema_migrations (version) VALUES ('20150429214043');

INSERT INTO schema_migrations (version) VALUES ('20150505010620');

INSERT INTO schema_migrations (version) VALUES ('20150505221558');

INSERT INTO schema_migrations (version) VALUES ('20150505231150');

INSERT INTO schema_migrations (version) VALUES ('20150506070756');

INSERT INTO schema_migrations (version) VALUES ('20150511192653');

INSERT INTO schema_migrations (version) VALUES ('20150511204318');

INSERT INTO schema_migrations (version) VALUES ('20150511231750');

INSERT INTO schema_migrations (version) VALUES ('20150511232019');

INSERT INTO schema_migrations (version) VALUES ('20150511232424');

INSERT INTO schema_migrations (version) VALUES ('20150511232722');

INSERT INTO schema_migrations (version) VALUES ('20150512200917');

INSERT INTO schema_migrations (version) VALUES ('20150518232728');

INSERT INTO schema_migrations (version) VALUES ('20150518232729');

INSERT INTO schema_migrations (version) VALUES ('20150519222951');

INSERT INTO schema_migrations (version) VALUES ('20150526212209');

INSERT INTO schema_migrations (version) VALUES ('20150528185129');

INSERT INTO schema_migrations (version) VALUES ('20150529185551');

INSERT INTO schema_migrations (version) VALUES ('20150608193745');

INSERT INTO schema_migrations (version) VALUES ('20150611222814');

INSERT INTO schema_migrations (version) VALUES ('20150611224551');

INSERT INTO schema_migrations (version) VALUES ('20150611225651');

INSERT INTO schema_migrations (version) VALUES ('20150616191909');

INSERT INTO schema_migrations (version) VALUES ('20150617193801');

INSERT INTO schema_migrations (version) VALUES ('20150619211826');

INSERT INTO schema_migrations (version) VALUES ('20150619211829');

INSERT INTO schema_migrations (version) VALUES ('20150625102501');

INSERT INTO schema_migrations (version) VALUES ('20150629152529');

INSERT INTO schema_migrations (version) VALUES ('20150701130359');

INSERT INTO schema_migrations (version) VALUES ('20150702012326');

INSERT INTO schema_migrations (version) VALUES ('20150702100444');

INSERT INTO schema_migrations (version) VALUES ('20150702183244');

INSERT INTO schema_migrations (version) VALUES ('20150702200844');

INSERT INTO schema_migrations (version) VALUES ('20150703101304');

INSERT INTO schema_migrations (version) VALUES ('20150703144829');

INSERT INTO schema_migrations (version) VALUES ('20150703155901');

INSERT INTO schema_migrations (version) VALUES ('20150703193223');

INSERT INTO schema_migrations (version) VALUES ('20150709203417');

INSERT INTO schema_migrations (version) VALUES ('20150710163437');

INSERT INTO schema_migrations (version) VALUES ('20150714010121');

INSERT INTO schema_migrations (version) VALUES ('20150714183737');

INSERT INTO schema_migrations (version) VALUES ('20150714212023');

INSERT INTO schema_migrations (version) VALUES ('20150714230628');

INSERT INTO schema_migrations (version) VALUES ('20150717142623');

INSERT INTO schema_migrations (version) VALUES ('20150722170453');

INSERT INTO schema_migrations (version) VALUES ('20150722172025');

INSERT INTO schema_migrations (version) VALUES ('20150722214310');

INSERT INTO schema_migrations (version) VALUES ('20150729111302');

INSERT INTO schema_migrations (version) VALUES ('20150729205818');

INSERT INTO schema_migrations (version) VALUES ('20150804192046');

INSERT INTO schema_migrations (version) VALUES ('20150804201329');

INSERT INTO schema_migrations (version) VALUES ('20150806165627');

INSERT INTO schema_migrations (version) VALUES ('20150810174337');

INSERT INTO schema_migrations (version) VALUES ('20150830155225');

INSERT INTO schema_migrations (version) VALUES ('20150914155223');

INSERT INTO schema_migrations (version) VALUES ('20150914155224');

INSERT INTO schema_migrations (version) VALUES ('20150914155225');

INSERT INTO schema_migrations (version) VALUES ('20150914155226');

INSERT INTO schema_migrations (version) VALUES ('20150914155227');

INSERT INTO schema_migrations (version) VALUES ('20150914155228');

INSERT INTO schema_migrations (version) VALUES ('20150914155229');

INSERT INTO schema_migrations (version) VALUES ('20150914155230');

INSERT INTO schema_migrations (version) VALUES ('20150914155231');

INSERT INTO schema_migrations (version) VALUES ('20150914155232');

INSERT INTO schema_migrations (version) VALUES ('20150914155233');

INSERT INTO schema_migrations (version) VALUES ('20150914155234');

INSERT INTO schema_migrations (version) VALUES ('20150914155235');

INSERT INTO schema_migrations (version) VALUES ('20150917222249');

INSERT INTO schema_migrations (version) VALUES ('20150918201131');

INSERT INTO schema_migrations (version) VALUES ('20150923222009');

INSERT INTO schema_migrations (version) VALUES ('20150925181643');

INSERT INTO schema_migrations (version) VALUES ('20150928182516');

INSERT INTO schema_migrations (version) VALUES ('20150929002425');

INSERT INTO schema_migrations (version) VALUES ('20150929002527');

INSERT INTO schema_migrations (version) VALUES ('20151008184324');

INSERT INTO schema_migrations (version) VALUES ('20151013202817');

INSERT INTO schema_migrations (version) VALUES ('20151014231356');

INSERT INTO schema_migrations (version) VALUES ('20151019210519');

INSERT INTO schema_migrations (version) VALUES ('20151020004438');

INSERT INTO schema_migrations (version) VALUES ('20151023171534');

INSERT INTO schema_migrations (version) VALUES ('20151023171550');

INSERT INTO schema_migrations (version) VALUES ('20151023205259');

INSERT INTO schema_migrations (version) VALUES ('20151026194948');

INSERT INTO schema_migrations (version) VALUES ('20151027204421');

INSERT INTO schema_migrations (version) VALUES ('20151030221553');

INSERT INTO schema_migrations (version) VALUES ('20151102212331');

INSERT INTO schema_migrations (version) VALUES ('20151102225846');

INSERT INTO schema_migrations (version) VALUES ('20151103215244');

INSERT INTO schema_migrations (version) VALUES ('20151105213059');

INSERT INTO schema_migrations (version) VALUES ('20151109213855');

INSERT INTO schema_migrations (version) VALUES ('20151110204524');

INSERT INTO schema_migrations (version) VALUES ('20151110235115');

INSERT INTO schema_migrations (version) VALUES ('20151111200655');

INSERT INTO schema_migrations (version) VALUES ('20151112004702');

INSERT INTO schema_migrations (version) VALUES ('20151112194946');

INSERT INTO schema_migrations (version) VALUES ('20151117234636');

INSERT INTO schema_migrations (version) VALUES ('20151124002708');

INSERT INTO schema_migrations (version) VALUES ('20151125203137');

INSERT INTO schema_migrations (version) VALUES ('20151201212947');

INSERT INTO schema_migrations (version) VALUES ('20151203231755');

INSERT INTO schema_migrations (version) VALUES ('20151207193956');

INSERT INTO schema_migrations (version) VALUES ('20151208205901');

INSERT INTO schema_migrations (version) VALUES ('20151210224821');

INSERT INTO schema_migrations (version) VALUES ('20151211224013');

INSERT INTO schema_migrations (version) VALUES ('20151214231554');

INSERT INTO schema_migrations (version) VALUES ('20151215003609');

INSERT INTO schema_migrations (version) VALUES ('20151215223124');

INSERT INTO schema_migrations (version) VALUES ('20151216200007');

INSERT INTO schema_migrations (version) VALUES ('20151217004628');

INSERT INTO schema_migrations (version) VALUES ('20151217202437');

INSERT INTO schema_migrations (version) VALUES ('20151217203031');

INSERT INTO schema_migrations (version) VALUES ('20151217215326');

INSERT INTO schema_migrations (version) VALUES ('20151217231231');

INSERT INTO schema_migrations (version) VALUES ('20151222160559');

INSERT INTO schema_migrations (version) VALUES ('20151223151630');

INSERT INTO schema_migrations (version) VALUES ('20160112004021');

INSERT INTO schema_migrations (version) VALUES ('20160115234113');

INSERT INTO schema_migrations (version) VALUES ('20160119203420');

INSERT INTO schema_migrations (version) VALUES ('20160121232134');

INSERT INTO schema_migrations (version) VALUES ('20160122015518');

INSERT INTO schema_migrations (version) VALUES ('20160122225212');

INSERT INTO schema_migrations (version) VALUES ('20160127174656');

INSERT INTO schema_migrations (version) VALUES ('20160127193819');

INSERT INTO schema_migrations (version) VALUES ('20160127200019');

INSERT INTO schema_migrations (version) VALUES ('20160128222903');

INSERT INTO schema_migrations (version) VALUES ('20160128223505');

INSERT INTO schema_migrations (version) VALUES ('20160203211100');

INSERT INTO schema_migrations (version) VALUES ('20160216180944');

INSERT INTO schema_migrations (version) VALUES ('20160216211707');

INSERT INTO schema_migrations (version) VALUES ('20160218153622');

INSERT INTO schema_migrations (version) VALUES ('20160218182823');

INSERT INTO schema_migrations (version) VALUES ('20160219183255');

INSERT INTO schema_migrations (version) VALUES ('20160219214006');

INSERT INTO schema_migrations (version) VALUES ('20160222235429');

INSERT INTO schema_migrations (version) VALUES ('20160223021154');

INSERT INTO schema_migrations (version) VALUES ('20160224233922');

INSERT INTO schema_migrations (version) VALUES ('20160229212223');

INSERT INTO schema_migrations (version) VALUES ('20160229212350');

INSERT INTO schema_migrations (version) VALUES ('20160229222613');

INSERT INTO schema_migrations (version) VALUES ('20160229223642');

INSERT INTO schema_migrations (version) VALUES ('20160304160954');

INSERT INTO schema_migrations (version) VALUES ('20160304185010');

INSERT INTO schema_migrations (version) VALUES ('20160309222601');

INSERT INTO schema_migrations (version) VALUES ('20160310203111');

INSERT INTO schema_migrations (version) VALUES ('20160310215402');

INSERT INTO schema_migrations (version) VALUES ('20160311000118');

INSERT INTO schema_migrations (version) VALUES ('20160315201430');

INSERT INTO schema_migrations (version) VALUES ('20160315222408');

INSERT INTO schema_migrations (version) VALUES ('20160315224708');

INSERT INTO schema_migrations (version) VALUES ('20160318203043');

INSERT INTO schema_migrations (version) VALUES ('20160318213835');

INSERT INTO schema_migrations (version) VALUES ('20160322215824');

INSERT INTO schema_migrations (version) VALUES ('20160323221734');

INSERT INTO schema_migrations (version) VALUES ('20160325190311');

INSERT INTO schema_migrations (version) VALUES ('20160328214106');

INSERT INTO schema_migrations (version) VALUES ('20160328214127');

INSERT INTO schema_migrations (version) VALUES ('20160328214144');

INSERT INTO schema_migrations (version) VALUES ('20160330005541');

INSERT INTO schema_migrations (version) VALUES ('20160330205837');

INSERT INTO schema_migrations (version) VALUES ('20160330225901');

INSERT INTO schema_migrations (version) VALUES ('20160331003038');

INSERT INTO schema_migrations (version) VALUES ('20160331193810');

INSERT INTO schema_migrations (version) VALUES ('20160401205314');

INSERT INTO schema_migrations (version) VALUES ('20160405204712');

INSERT INTO schema_migrations (version) VALUES ('20160405235707');

INSERT INTO schema_migrations (version) VALUES ('20160406183030');

INSERT INTO schema_migrations (version) VALUES ('20160407191945');

INSERT INTO schema_migrations (version) VALUES ('20160408123603');

INSERT INTO schema_migrations (version) VALUES ('20160408191018');

INSERT INTO schema_migrations (version) VALUES ('20160412225808');

INSERT INTO schema_migrations (version) VALUES ('20160414214937');

INSERT INTO schema_migrations (version) VALUES ('20160414224608');

INSERT INTO schema_migrations (version) VALUES ('20160414224629');

INSERT INTO schema_migrations (version) VALUES ('20160414232448');

INSERT INTO schema_migrations (version) VALUES ('20160414232508');

INSERT INTO schema_migrations (version) VALUES ('20160414232855');

INSERT INTO schema_migrations (version) VALUES ('20160415220035');

INSERT INTO schema_migrations (version) VALUES ('20160418233150');

INSERT INTO schema_migrations (version) VALUES ('20160419183353');

INSERT INTO schema_migrations (version) VALUES ('20160420181221');

INSERT INTO schema_migrations (version) VALUES ('20160420181621');

INSERT INTO schema_migrations (version) VALUES ('20160425175826');

INSERT INTO schema_migrations (version) VALUES ('20160425182006');

INSERT INTO schema_migrations (version) VALUES ('20160426232052');

INSERT INTO schema_migrations (version) VALUES ('20160427230454');

INSERT INTO schema_migrations (version) VALUES ('20160502200957');

INSERT INTO schema_migrations (version) VALUES ('20160504191529');

INSERT INTO schema_migrations (version) VALUES ('20160504191545');

INSERT INTO schema_migrations (version) VALUES ('20160504205917');

INSERT INTO schema_migrations (version) VALUES ('20160505001124');

INSERT INTO schema_migrations (version) VALUES ('20160505164817');

INSERT INTO schema_migrations (version) VALUES ('20160506000655');

INSERT INTO schema_migrations (version) VALUES ('20160506221833');

INSERT INTO schema_migrations (version) VALUES ('20160510203508');

INSERT INTO schema_migrations (version) VALUES ('20160510203831');

INSERT INTO schema_migrations (version) VALUES ('20160510203849');

INSERT INTO schema_migrations (version) VALUES ('20160510203906');

INSERT INTO schema_migrations (version) VALUES ('20160510203925');

INSERT INTO schema_migrations (version) VALUES ('20160510203942');

INSERT INTO schema_migrations (version) VALUES ('20160510204002');

INSERT INTO schema_migrations (version) VALUES ('20160510222719');

INSERT INTO schema_migrations (version) VALUES ('20160511222102');

INSERT INTO schema_migrations (version) VALUES ('20160513200656');

INSERT INTO schema_migrations (version) VALUES ('20160513231740');

INSERT INTO schema_migrations (version) VALUES ('20160516194756');

INSERT INTO schema_migrations (version) VALUES ('20160517175500');

INSERT INTO schema_migrations (version) VALUES ('20160517175824');

INSERT INTO schema_migrations (version) VALUES ('20160517233354');

INSERT INTO schema_migrations (version) VALUES ('20160518175010');

INSERT INTO schema_migrations (version) VALUES ('20160519215045');

INSERT INTO schema_migrations (version) VALUES ('20160523213437');

INSERT INTO schema_migrations (version) VALUES ('20160524200815');

INSERT INTO schema_migrations (version) VALUES ('20160525004259');

INSERT INTO schema_migrations (version) VALUES ('20160525220024');

INSERT INTO schema_migrations (version) VALUES ('20160525223701');

INSERT INTO schema_migrations (version) VALUES ('20160525223735');

INSERT INTO schema_migrations (version) VALUES ('20160527175103');

INSERT INTO schema_migrations (version) VALUES ('20160527212258');

INSERT INTO schema_migrations (version) VALUES ('20160527223217');

INSERT INTO schema_migrations (version) VALUES ('20160531145728');

INSERT INTO schema_migrations (version) VALUES ('20160603165943');

INSERT INTO schema_migrations (version) VALUES ('20160609235909');

INSERT INTO schema_migrations (version) VALUES ('20160613233843');

INSERT INTO schema_migrations (version) VALUES ('20160614202611');

INSERT INTO schema_migrations (version) VALUES ('20160614205414');

INSERT INTO schema_migrations (version) VALUES ('20160615194940');

INSERT INTO schema_migrations (version) VALUES ('20160615220257');

INSERT INTO schema_migrations (version) VALUES ('20160615225817');

INSERT INTO schema_migrations (version) VALUES ('20160617000556');

INSERT INTO schema_migrations (version) VALUES ('20160617172848');

INSERT INTO schema_migrations (version) VALUES ('20160617184242');

INSERT INTO schema_migrations (version) VALUES ('20160617200037');

INSERT INTO schema_migrations (version) VALUES ('20160617200110');

INSERT INTO schema_migrations (version) VALUES ('20160617203711');

INSERT INTO schema_migrations (version) VALUES ('20160617223753');

INSERT INTO schema_migrations (version) VALUES ('20160623000011');

INSERT INTO schema_migrations (version) VALUES ('20160623171452');

INSERT INTO schema_migrations (version) VALUES ('20160623182902');

INSERT INTO schema_migrations (version) VALUES ('20160623200146');

INSERT INTO schema_migrations (version) VALUES ('20160623234639');

INSERT INTO schema_migrations (version) VALUES ('20160627183454');

INSERT INTO schema_migrations (version) VALUES ('20160629171216');

INSERT INTO schema_migrations (version) VALUES ('20160629184112');

INSERT INTO schema_migrations (version) VALUES ('20160629200529');

INSERT INTO schema_migrations (version) VALUES ('20160629201456');

INSERT INTO schema_migrations (version) VALUES ('20160629215130');

INSERT INTO schema_migrations (version) VALUES ('20160630155617');

INSERT INTO schema_migrations (version) VALUES ('20160630223304');

INSERT INTO schema_migrations (version) VALUES ('20160701202925');

INSERT INTO schema_migrations (version) VALUES ('20160705185319');

INSERT INTO schema_migrations (version) VALUES ('20160706200721');

INSERT INTO schema_migrations (version) VALUES ('20160707174649');

INSERT INTO schema_migrations (version) VALUES ('20160707182319');

INSERT INTO schema_migrations (version) VALUES ('20160711184239');

INSERT INTO schema_migrations (version) VALUES ('20160711184755');

INSERT INTO schema_migrations (version) VALUES ('20160711230439');

INSERT INTO schema_migrations (version) VALUES ('20160712214517');

INSERT INTO schema_migrations (version) VALUES ('20160712221011');

INSERT INTO schema_migrations (version) VALUES ('20160713193031');

INSERT INTO schema_migrations (version) VALUES ('20160713231301');

INSERT INTO schema_migrations (version) VALUES ('20160713232711');

INSERT INTO schema_migrations (version) VALUES ('20160713232740');

INSERT INTO schema_migrations (version) VALUES ('20160714003255');

INSERT INTO schema_migrations (version) VALUES ('20160714162413');

INSERT INTO schema_migrations (version) VALUES ('20160714231439');

INSERT INTO schema_migrations (version) VALUES ('20160715183137');

INSERT INTO schema_migrations (version) VALUES ('20160715183408');

INSERT INTO schema_migrations (version) VALUES ('20160715185059');

INSERT INTO schema_migrations (version) VALUES ('20160715202708');

INSERT INTO schema_migrations (version) VALUES ('20160718233111');

INSERT INTO schema_migrations (version) VALUES ('20160719233809');

INSERT INTO schema_migrations (version) VALUES ('20160720205452');

INSERT INTO schema_migrations (version) VALUES ('20160721195039');

INSERT INTO schema_migrations (version) VALUES ('20160721195234');

INSERT INTO schema_migrations (version) VALUES ('20160721195334');

INSERT INTO schema_migrations (version) VALUES ('20160721200617');

INSERT INTO schema_migrations (version) VALUES ('20160721201637');

INSERT INTO schema_migrations (version) VALUES ('20160727211739');

INSERT INTO schema_migrations (version) VALUES ('20160727213504');

INSERT INTO schema_migrations (version) VALUES ('20160728005306');

INSERT INTO schema_migrations (version) VALUES ('20160728170725');

INSERT INTO schema_migrations (version) VALUES ('20160728172033');

INSERT INTO schema_migrations (version) VALUES ('20160728181912');

INSERT INTO schema_migrations (version) VALUES ('20160728234347');

INSERT INTO schema_migrations (version) VALUES ('20160729162415');

INSERT INTO schema_migrations (version) VALUES ('20160801180131');

INSERT INTO schema_migrations (version) VALUES ('20160801234347');

INSERT INTO schema_migrations (version) VALUES ('20160804010031');

INSERT INTO schema_migrations (version) VALUES ('20160804182527');

INSERT INTO schema_migrations (version) VALUES ('20160804193540');

INSERT INTO schema_migrations (version) VALUES ('20160805171049');

INSERT INTO schema_migrations (version) VALUES ('20160809205124');

INSERT INTO schema_migrations (version) VALUES ('20160810195647');

INSERT INTO schema_migrations (version) VALUES ('20160812205556');

INSERT INTO schema_migrations (version) VALUES ('20160812215804');

INSERT INTO schema_migrations (version) VALUES ('20160816225236');

INSERT INTO schema_migrations (version) VALUES ('20160817200005');

INSERT INTO schema_migrations (version) VALUES ('20160819063211');

INSERT INTO schema_migrations (version) VALUES ('20160819174413');