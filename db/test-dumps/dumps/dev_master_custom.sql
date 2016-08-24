-- In devbox sphinx queries the dev db and expects this index to be present
ALTER TABLE dev_master.word_documents
    ADD INDEX  `idx_sphinx` (`published`,`removal_id`,`deleted`,`id`);

