INSERT INTO `word_user_statuses` (`id`, `deleted`, `blocked`, `show_topbar_nag`, `has_seen_passive_sharing_dialog`, `has_uploaded_photo`, `use_facebook_photo`) VALUES (1, 0, 0, 0, 0, 0, 1);
CREATE TABLE `facebook_user_data` (`facebook_id` bigint NOT NULL, `serialized_data` text, UNIQUE KEY `idx_facebook` (`facebook_id`)) ENGINE=InnoDB;
