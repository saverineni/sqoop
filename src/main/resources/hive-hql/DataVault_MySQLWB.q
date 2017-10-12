DROP TABLE IF EXISTS `${DATAVAULT_DB}`.hub_additional_info;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`hub_additional_info` ( `hub_additional_info_key` STRING, `hub_load_datetime` STRING, `hub_record_source` STRING, `entry_reference` STRING, `item_number` STRING, `additional_information_sequence_number` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.hub_commodity;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`hub_commodity` ( `hub_commodity_key` STRING, `commodity_code` STRING, `hub_load_datetime` STRING, `hub_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.hub_country;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`hub_country` ( `hub_country_key` STRING, `iso_country_code_alpha_2` STRING, `hub_load_datetime` STRING, `hub_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.hub_currency;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`hub_currency` ( `hub_currency_key` STRING, `currency_iso_code` STRING, `hub_load_datetime` STRING, `hub_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.hub_customs_procedure_code;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`hub_customs_procedure_code` ( `hub_customs_procedure_code_key` STRING, `customs_procedure_code` STRING, `hub_load_datetime` STRING, `hub_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.hub_declaration;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`hub_declaration` ( `hub_declaration_key` STRING, `entry_reference` STRING, `hub_load_datetime` STRING, `hub_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.hub_declaration_line;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`hub_declaration_line` ( `hub_declaration_line_key` STRING, `hub_load_datetime` STRING, `hub_record_source` STRING, `entry_reference` STRING, `item_number` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.hub_document;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`hub_document` ( `hub_document_key` STRING, `hub_load_datetime` STRING, `hub_record_source` STRING, `entry_reference` STRING, `item_number` STRING, `document_sequence_number` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.hub_previous_document;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`hub_previous_document` ( `hub_previous_document_key` STRING, `hub_load_datetime` STRING, `hub_record_source` STRING, `entry_reference` STRING, `item_number` STRING, `previous_document_sequence_number` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.hub_tax_line;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`hub_tax_line` ( `hub_tax_line_key` STRING, `hub_load_datetime` STRING, `hub_record_source` STRING, `entry_reference` STRING, `item_number` STRING, `tax_line_sequence_number` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.hub_trader;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`hub_trader` ( `hub_trader_key` STRING, `turn` STRING, `hub_load_datetime` STRING, `hub_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_consignor_trader;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_consignor_trader` ( `link_declaration_consignor_trader_key` STRING, `hub_declaration_key` STRING, `hub_trader_key` STRING, `entry_reference` STRING, `turn` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_declarant_trader;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_declarant_trader` ( `link_declaration_declarant_trader_key` STRING, `hub_declaration_key` STRING, `hub_trader_key` STRING, `entry_reference` STRING, `turn` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_destination_country;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_destination_country` ( `link_declaration_destination_country_key` STRING, `hub_declaration_key` STRING, `hub_country_key` STRING, `entry_reference` STRING, `iso_country_code_alpha_2` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_exporter_trader;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_exporter_trader` ( `link_declaration_exporter_trader_key` STRING, `hub_declaration_key` STRING, `hub_trader_key` STRING, `entry_reference` STRING, `turn` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_freight_currency;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_freight_currency` ( `link_declaration_freight_currency_key` STRING, `hub_declaration_key` STRING, `hub_currency_key` STRING, `entry_reference` STRING, `currency_iso_code` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_importer_trader;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_importer_trader` ( `link_declaration_importer_trader_key` STRING, `hub_declaration_key` STRING, `hub_trader_key` STRING, `entry_reference` STRING, `turn` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_invoice_currency;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_invoice_currency` ( `link_declaration_freight_currency_key` STRING, `hub_declaration_key` STRING, `hub_currency_key` STRING, `entry_reference` STRING, `currency_iso_code` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_line_additional_info;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_line_additional_info` ( `link_declaration_line_additional_info_key` STRING, `hub_declaration_line_key` STRING, `hub_additional_info_key` STRING, `entry_reference` STRING, `item_number` STRING, `additional_information_sequence_number` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_line_commodity;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_line_commodity` ( `link_declaration_line_commodity_key` STRING, `hub_declaration_line_key` STRING, `hub_commodity_key` STRING, `entry_reference` STRING, `item_number` STRING, `commodity_code` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_line_customs_procedure_code;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_line_customs_procedure_code` ( `link_declaration_line_customs_procedure_code_key` STRING, `hub_declaration_line_key` STRING, `hub_customs_procedure_code_key` STRING, `entry_reference` STRING, `item_number` STRING, `customs_procedure_code` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_line_declaration;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_line_declaration` ( `link_declaration_line_declaration_key` STRING, `hub_declaration_line_key` STRING, `hub_declaration_key` STRING, `link_load_datetime` STRING, `link_record_source` STRING, `entry_reference` STRING, `item_number` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_line_document;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_line_document` ( `link_declaration_line_document_key` STRING, `hub_declaration_line_key` STRING, `hub_document_key` STRING, `entry_reference` STRING, `item_number` STRING, `document_sequence_number` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_line_importer_trader;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_line_importer_trader` ( `link_declaration_line_importer_trader_key` STRING, `hub_declaration_line_key` STRING, `hub_trader_key` STRING, `entry_reference` STRING, `item_number` STRING, `turn` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_line_origin_country;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_line_origin_country` ( `link_declaration_line_origin_country_key` STRING, `hub_declaration_line_key` STRING, `hub_country_key` STRING, `entry_reference` STRING, `item_number` STRING, `iso_country_code_alpha_2` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_line_previous_document;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_line_previous_document` ( `link_declaration_line_document_key` STRING, `hub_declaration_line_key` STRING, `hub_document_key` STRING, `entry_reference` STRING, `item_number` STRING, `previous_document_sequence_number` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_line_tax_line;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_line_tax_line` ( `link_declaration_line_tax_line_key` STRING, `hub_declaration_line_key` STRING, `hub_tax_line_key` STRING, `entry_reference` STRING, `item_number` STRING, `tax_line_sequence_number` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_paying_agent_trader;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_paying_agent_trader` ( `link_declaration_paying_agent_trader_key` STRING, `hub_declaration_key` STRING, `hub_trader_key` STRING, `entry_reference` STRING, `turn` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.link_declaration_transport_country;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`link_declaration_transport_country` ( `link_declaration_destination_country_key` STRING, `hub_declaration_key` STRING, `hub_country_key` STRING, `entry_reference` STRING, `iso_country_code_alpha_2` STRING, `link_load_datetime` STRING, `link_record_source` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.sat_additional_info;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`sat_additional_info` ( `hub_additional_info_key` STRING, `sat_hash_diff` STRING, `sat_load_datetime` STRING, `sat_load_end_datetime` STRING, `sat_record_source` STRING, `generation_number` STRING, `additional_information_statement` STRING, `additional_information_statement_type` STRING, `item_additional_information_statement` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.sat_commodity;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`sat_commodity` ( `hub_commodity_key` STRING, `sat_hash_diff` STRING, `sat_load_datetime` STRING, `sat_load_end_datetime` STRING, `sat_record_source` STRING, `cc_year` STRING, `cc_month` STRING, `hs_chapter` STRING, `hs_heading` STRING, `hs_chapter_heading` STRING, `hs_subheading` STRING, `chapter_description` STRING, `heading_description` STRING, `subheading_description` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.sat_country;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`sat_country` ( `hub_country_key` STRING, `sat_hash_diff` STRING, `sat_load_datetime` STRING, `sat_load_end_datetime` STRING, `sat_record_source` STRING, `country_name` STRING, `country_sequence_number` STRING, `country_comments` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.sat_currency;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`sat_currency` ( `hub_currency_key` STRING, `sat_hash_diff` STRING, `sat_load_datetime` STRING, `sat_load_end_datetime` STRING, `sat_record_source` STRING, `currency_name` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.sat_declaration;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`sat_declaration` ( `hub_declaration_key` STRING, `sat_hash_diff` STRING, `sat_load_datetime` STRING, `sat_load_end_datetime` STRING, `sat_record_source` STRING, `entry_number` STRING, `entry_date` STRING, `epu_number` STRING, `entry_type` STRING, `declaration_method` STRING, `total_excise` STRING, `declarant_representative_turn` STRING, `consignee_aeo_certificate_type_code` STRING, `declarant_aeo_certificate_type_code` STRING, `route` STRING, `declaration_import_export_indicator` STRING, `generation_number` STRING, `import_clearance_status` STRING, `consignor_aeo_certificate_type_code` STRING, `header_statistical_value` STRING, `goods_departure_datetime` STRING, `customs_value` STRING, `total_duty` STRING, `total_vat` STRING, `net_mass_total` STRING, `goods_location` STRING, `acceptance_date` STRING, `importer_turn_country_code` STRING, `place_of_unloading_code` STRING, `first_deferment_approval_num` STRING, `first_deferment_approval_num_prefix` STRING, `declaration_ucr` STRING, `item_count` STRING, `master_ucr` STRING, `paying_agent_turn` STRING, `place_of_loading_code` STRING, `session_num` STRING, `session_role_name` STRING, `status_of_entry` STRING, `transport_country` STRING, `transport_id` STRING, `transport_mode_code` STRING, `dispatch_country` STRING, `consignor_turn_country_code` STRING, `consignor_nad_name` STRING, `consignee_nad_name` STRING, `consignee_nad_postcode` STRING, `declarant_nad_name` STRING, `customs_check_code` STRING, `profile_id` STRING, `invoice_total_declared` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.sat_declaration_line;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`sat_declaration_line` ( `hub_declaration_line_key` STRING, `sat_hash_diff` STRING, `sat_load_datetime` STRING, `sat_load_end_datetime` STRING, `sat_record_source` STRING, `clearance_datetime` STRING, `item_statistical_value` STRING, `customs_duty_paid` STRING, `vat_paid` STRING, `ec_supplementary_1` STRING, `item_customs_value` STRING, `item_net_mass` STRING, `item_supplementary_units` STRING, `goods_description` STRING, `item_customs_check_code` STRING, `item_mic_code` STRING, `item_profile_id` STRING, `item_consignor_nad_name` STRING, `item_consignee_nad_name` STRING, `item_consignee_nad_postcode` STRING, `vat_value` STRING, `item_price_declared` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.sat_document;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`sat_document` ( `hub_document_key` STRING, `sat_hash_diff` STRING, `sat_load_datetime` STRING, `sat_load_end_datetime` STRING, `sat_record_source` STRING, `generation_number` STRING, `item_document_code` STRING, `item_document_status` STRING, `item_document_reference` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.sat_previous_document;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`sat_previous_document` ( `hub_previous_document_key` STRING, `sat_hash_diff` STRING, `sat_load_datetime` STRING, `sat_load_end_datetime` STRING, `sat_record_source` STRING, `previous_document_reference` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.sat_tax_line;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`sat_tax_line` ( `hub_tax_line_key` STRING, `sat_hash_diff` STRING, `sat_load_datetime` STRING, `sat_load_end_datetime` STRING, `sat_record_source` STRING, `generation_number` STRING, `waived_tax` STRING, `method_of_payment_code` STRING, `tax_amount` STRING, `tax_type_code` STRING) STORED AS TEXTFILE;

DROP TABLE IF EXISTS `${DATAVAULT_DB}`.sat_trader;
CREATE TABLE IF NOT EXISTS `${DATAVAULT_DB}`.`sat_trader` ( `hub_trader_key` STRING, `sat_hash_diff` STRING, `sat_load_datetime` STRING, `sat_load_end_datetime` STRING, `sat_record_source` STRING, `name` STRING, `simplified_procedure_authorisations` STRING, `trader_name_abbreviated` STRING, `currentind` STRING) STORED AS TEXTFILE;

