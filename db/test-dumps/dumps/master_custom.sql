REPLACE INTO `options` VALUES ('enable_followship','[true]','This option is used to toggle Followhips functionality.','2011-05-06 20:28:41',0,0);

REPLACE INTO `copyrights` (`id`, `name`, `url`, `display_order`, `image_url`)
VALUES
  (1, 'Traditional Copyright: All rights reserved', 'http://www.copyright.gov/title17/', 8, '/images/traditional_copyright.png'),
  (2, 'Attribution', 'http://creativecommons.org/licenses/by/3.0/', 2, '/images/attribution.png'),
  (3, 'Attribution Non-commercial', 'http://creativecommons.org/licenses/by-nc/3.0/', 3, '/images/attribution_noncommercial.png'),
  (4, 'Attribution Non-commercial No-derivs', 'http://creativecommons.org/licenses/by-nc-nd/3.0/', 4, '/images/attribution_noncommercial_noderivatives.png'),
  (5, 'Public Domain', 'http://www.creativecommons.org/licenses/publicdomain', 1, '/images/public_domain.png'),
  (6, 'Attribution Non-commercial Share Alike', 'http://creativecommons.org/licenses/by-nc-sa/3.0/', 5, '/images/attribution_noncommercial_share.png'),
  (7, 'Attribution Share Alike', 'http://creativecommons.org/licenses/by-sa/3.0/', 6, '/images/attribution_share.png'),
  (8, 'Attribution No Derivatives', 'http://creativecommons.org/licenses/by-nd/3.0/', 7, '/images/attribution_noderivatives.png');
