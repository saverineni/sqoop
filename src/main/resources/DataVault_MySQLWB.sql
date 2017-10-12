-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: mydb, DataVault
-- Source Schemata: mydb, DataVault
-- Created: Thu Oct 12 14:37:46 2017
-- Workbench Version: 6.3.9
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema mydb
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;

-- ----------------------------------------------------------------------------
-- Schema DataVault
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `DataVault` ;
CREATE SCHEMA IF NOT EXISTS `DataVault` DEFAULT CHARACTER SET latin1 ;

-- ----------------------------------------------------------------------------
-- Table DataVault.hub_commodity
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`hub_commodity` (
  `hub_commodity_key` CHAR(32) NOT NULL,
  `commodity_code` VARCHAR(255) NOT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"hs_code\"\n        }\n    }\n}',
  `hub_load_datetime` DATETIME NOT NULL,
  `hub_record_source` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`hub_commodity_key`, `hub_load_datetime`, `hub_record_source`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"dim_commodity_code\",\n            \"record_source_field\": {\n                \"type\": \"literal\",\n                \"value\": \"dim_commodity_code\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.hub_country
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`hub_country` (
  `hub_country_key` CHAR(32) NOT NULL,
  `iso_country_code_alpha_2` CHAR(2) NOT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"country_iso_code\"\n        }\n    }\n}',
  `hub_load_datetime` DATETIME NOT NULL,
  `hub_record_source` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`hub_country_key`, `hub_load_datetime`, `hub_record_source`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"dim_country\",\n            \"record_source_field\": {\n                \"type\": \"literal\",\n                \"value\": \"dim_country\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.hub_customs_procedure_code
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`hub_customs_procedure_code` (
  `hub_customs_procedure_code_key` CHAR(32) NOT NULL,
  `customs_procedure_code` VARCHAR(255) NOT NULL,
  `hub_load_datetime` DATETIME NOT NULL,
  `hub_record_source` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`hub_customs_procedure_code_key`, `hub_load_datetime`, `hub_record_source`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"dim_customs_procedure_code\",\n            \"record_source_field\": {\n                \"type\": \"literal\",\n                \"value\": \"dim_customs_procedure_code\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.hub_declaration
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`hub_declaration` (
  `hub_declaration_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NOT NULL,
  `hub_load_datetime` DATETIME NOT NULL,
  `hub_record_source` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`hub_declaration_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_headers_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.hub_declaration_line
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`hub_declaration_line` (
  `hub_declaration_line_key` CHAR(32) NOT NULL,
  `hub_load_datetime` DATETIME NOT NULL,
  `hub_record_source` VARCHAR(255) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `item_number` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`hub_declaration_line_key`, `hub_load_datetime`, `hub_record_source`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_lines_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.hub_trader
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`hub_trader` (
  `hub_trader_key` CHAR(32) NOT NULL,
  `turn` VARCHAR(255) NOT NULL,
  `hub_load_datetime` DATETIME NOT NULL,
  `hub_record_source` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`hub_trader_key`, `hub_load_datetime`, `hub_record_source`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_trader\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_declarant_trader
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_declarant_trader` (
  `link_declaration_declarant_trader_key` CHAR(32) NOT NULL,
  `hub_declaration_key` CHAR(32) NOT NULL,
  `hub_trader_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `turn` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"declarant_turn\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `fk_link_declaration_declarant_trader_hub_declaration` (`hub_declaration_key` ASC),
  INDEX `fk_link_declaration_declarant_trader_hub_trader` (`hub_trader_key` ASC),
  CONSTRAINT `fk_link_declaration_declarant_trader_hub_declaration`
    FOREIGN KEY (`hub_declaration_key`)
    REFERENCES `DataVault`.`hub_declaration` (`hub_declaration_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_declarant_trader_hub_trader`
    FOREIGN KEY (`hub_trader_key`)
    REFERENCES `DataVault`.`hub_trader` (`hub_trader_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration\",\n            \"table\": \"landing_headers_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_line_declaration
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_line_declaration` (
  `link_declaration_line_declaration_key` CHAR(32) NOT NULL,
  `hub_declaration_line_key` CHAR(32) NOT NULL,
  `hub_declaration_key` CHAR(32) NOT NULL,
  `link_load_datetime` DATETIME NOT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `item_number` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`link_declaration_line_declaration_key`),
  INDEX `fk_lnk_declaration_declaration_line_hub_declaration` (`hub_declaration_key` ASC),
  INDEX `fk_lnk_declaration_declaration_line_hub_declaration_line` (`hub_declaration_line_key` ASC),
  CONSTRAINT `fk_lnk_declaration_declaration_line_hub_declaration`
    FOREIGN KEY (`hub_declaration_key`)
    REFERENCES `DataVault`.`hub_declaration` (`hub_declaration_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_declaration_declaration_line_hub_declaration_line`
    FOREIGN KEY (`hub_declaration_line_key`)
    REFERENCES `DataVault`.`hub_declaration_line` (`hub_declaration_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration_line\",\n            \"table\": \"landing_lines_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_importer_trader
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_importer_trader` (
  `link_declaration_importer_trader_key` CHAR(32) NOT NULL,
  `hub_declaration_key` CHAR(32) NOT NULL,
  `hub_trader_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `turn` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"importer_turn\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `fk_link_declaration_importer_trader_hub_declaration` (`hub_declaration_key` ASC),
  INDEX `fk_link_declaration_importer_trader_hub_trader` (`hub_trader_key` ASC),
  CONSTRAINT `fk_link_declaration_importer_trader_hub_declaration`
    FOREIGN KEY (`hub_declaration_key`)
    REFERENCES `DataVault`.`hub_declaration` (`hub_declaration_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_importer_trader_hub_trader`
    FOREIGN KEY (`hub_trader_key`)
    REFERENCES `DataVault`.`hub_trader` (`hub_trader_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration\",\n            \"table\": \"landing_headers_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_line_commodity
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_line_commodity` (
  `link_declaration_line_commodity_key` CHAR(32) NOT NULL,
  `hub_declaration_line_key` CHAR(32) NOT NULL,
  `hub_commodity_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `item_number` VARCHAR(255) NULL DEFAULT NULL,
  `commodity_code` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"hs_code\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`link_declaration_line_commodity_key`),
  INDEX `fk_link_declaration_line_commodity_hub_commodity` (`hub_commodity_key` ASC),
  INDEX `fk_link_declaration_line_commodity_hub_declaration_line` (`hub_declaration_line_key` ASC),
  CONSTRAINT `fk_link_declaration_line_commodity_hub_commodity`
    FOREIGN KEY (`hub_commodity_key`)
    REFERENCES `DataVault`.`hub_commodity` (`hub_commodity_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_line_commodity_hub_declaration_line`
    FOREIGN KEY (`hub_declaration_line_key`)
    REFERENCES `DataVault`.`hub_declaration_line` (`hub_declaration_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration_line\",\n            \"table\": \"landing_lines_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_line_customs_procedure_code
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_line_customs_procedure_code` (
  `link_declaration_line_customs_procedure_code_key` CHAR(32) NOT NULL,
  `hub_declaration_line_key` CHAR(32) NOT NULL,
  `hub_customs_procedure_code_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `item_number` VARCHAR(255) NULL DEFAULT NULL,
  `customs_procedure_code` VARCHAR(255) NULL DEFAULT NULL,
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`link_declaration_line_customs_procedure_code_key`),
  INDEX `fk_link_declaration_line_cpc_hub_customs_procedure_code` (`hub_customs_procedure_code_key` ASC),
  INDEX `fk_link_declaration_line_cpc_hub_declaration_line` (`hub_declaration_line_key` ASC),
  CONSTRAINT `fk_link_declaration_line_cpc_hub_customs_procedure_code`
    FOREIGN KEY (`hub_customs_procedure_code_key`)
    REFERENCES `DataVault`.`hub_customs_procedure_code` (`hub_customs_procedure_code_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_line_cpc_hub_declaration_line`
    FOREIGN KEY (`hub_declaration_line_key`)
    REFERENCES `DataVault`.`hub_declaration_line` (`hub_declaration_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration_line\",\n            \"table\": \"landing_lines_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_line_origin_country
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_line_origin_country` (
  `link_declaration_line_origin_country_key` CHAR(32) NOT NULL,
  `hub_declaration_line_key` CHAR(32) NOT NULL,
  `hub_country_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `item_number` VARCHAR(255) NULL DEFAULT NULL,
  `iso_country_code_alpha_2` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"origin_country_code\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`link_declaration_line_origin_country_key`),
  INDEX `fk_link_declaration_line_origin_country_hub_country` (`hub_country_key` ASC),
  INDEX `fk_link_declaration_line_origin_country_hub_declaration_line` (`hub_declaration_line_key` ASC),
  CONSTRAINT `fk_link_declaration_line_origin_country_hub_country`
    FOREIGN KEY (`hub_country_key`)
    REFERENCES `DataVault`.`hub_country` (`hub_country_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_line_origin_country_hub_declaration_line`
    FOREIGN KEY (`hub_declaration_line_key`)
    REFERENCES `DataVault`.`hub_declaration_line` (`hub_declaration_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration_line\",\n            \"table\": \"landing_lines_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.sat_commodity
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`sat_commodity` (
  `hub_commodity_key` CHAR(32) NOT NULL,
  `sat_hash_diff` CHAR(32) NOT NULL,
  `sat_load_datetime` DATETIME NOT NULL,
  `sat_load_end_datetime` DATETIME NOT NULL,
  `sat_record_source` VARCHAR(255) NOT NULL,
  `cc_year` VARCHAR(255) NULL DEFAULT NULL,
  `cc_month` VARCHAR(255) NULL DEFAULT NULL,
  `hs_chapter` VARCHAR(255) NULL DEFAULT NULL,
  `hs_heading` VARCHAR(255) NULL DEFAULT NULL,
  `hs_chapter_heading` VARCHAR(255) NULL DEFAULT NULL,
  `hs_subheading` VARCHAR(255) NULL DEFAULT NULL,
  `chapter_description` VARCHAR(255) NULL DEFAULT NULL,
  `heading_description` VARCHAR(255) NULL DEFAULT NULL,
  `subheading_description` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`hub_commodity_key`),
  CONSTRAINT `fk_sat_commodity_hub_commodity`
    FOREIGN KEY (`hub_commodity_key`)
    REFERENCES `DataVault`.`hub_commodity` (`hub_commodity_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"dim_commodity_code\",\n            \"record_source_field\": {\n                \"type\": \"literal\",\n                \"value\": \"dim_commodity_code\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.sat_country
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`sat_country` (
  `hub_country_key` CHAR(32) NOT NULL,
  `sat_hash_diff` CHAR(32) NOT NULL,
  `sat_load_datetime` DATETIME NULL DEFAULT NULL,
  `sat_load_end_datetime` DATETIME NOT NULL,
  `sat_record_source` VARCHAR(255) NULL DEFAULT NULL,
  `country_name` VARCHAR(255) NULL DEFAULT NULL,
  `country_sequence_number` VARCHAR(255) NULL DEFAULT NULL,
  `country_comments` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`hub_country_key`),
  CONSTRAINT `fk_sat_country_hub_country`
    FOREIGN KEY (`hub_country_key`)
    REFERENCES `DataVault`.`hub_country` (`hub_country_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"dim_country\",\n            \"record_source_field\": {\n                \"type\": \"literal\",\n                \"value\": \"dim_country\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.sat_declaration
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`sat_declaration` (
  `hub_declaration_key` CHAR(32) NOT NULL,
  `sat_hash_diff` CHAR(32) NOT NULL,
  `sat_load_datetime` DATETIME NOT NULL,
  `sat_load_end_datetime` DATETIME NULL DEFAULT NULL,
  `sat_record_source` VARCHAR(255) NULL DEFAULT NULL,
  `entry_number` VARCHAR(255) NULL DEFAULT NULL,
  `entry_date` VARCHAR(255) NULL DEFAULT NULL,
  `epu_number` VARCHAR(255) NULL DEFAULT NULL,
  `entry_type` VARCHAR(255) NULL DEFAULT NULL,
  `declaration_method` VARCHAR(255) NULL DEFAULT NULL,
  `total_excise` VARCHAR(255) NULL DEFAULT NULL,
  `declarant_representative_turn` VARCHAR(255) NULL DEFAULT NULL,
  `consignee_aeo_certificate_type_code` VARCHAR(255) NULL DEFAULT NULL,
  `declarant_aeo_certificate_type_code` VARCHAR(255) NULL DEFAULT NULL,
  `route` VARCHAR(255) NULL DEFAULT NULL,
  `declaration_import_export_indicator` VARCHAR(255) NULL,
  `generation_number` VARCHAR(255) NULL,
  `import_clearance_status` VARCHAR(255) NULL,
  `consignor_aeo_certificate_type_code` VARCHAR(255) NULL,
  `header_statistical_value` VARCHAR(255) NULL,
  `goods_departure_datetime` VARCHAR(255) NULL,
  `customs_value` VARCHAR(255) NULL,
  `total_duty` VARCHAR(255) NULL,
  `total_vat` VARCHAR(255) NULL,
  `net_mass_total` VARCHAR(255) NULL,
  `goods_location` VARCHAR(255) NULL,
  `acceptance_date` VARCHAR(255) NULL,
  `importer_turn_country_code` VARCHAR(255) NULL,
  `place_of_unloading_code` VARCHAR(255) NULL,
  `first_deferment_approval_num` VARCHAR(255) NULL,
  `first_deferment_approval_num_prefix` VARCHAR(255) NULL,
  `declaration_ucr` VARCHAR(255) NULL,
  `item_count` VARCHAR(255) NULL,
  `master_ucr` VARCHAR(255) NULL,
  `paying_agent_turn` VARCHAR(255) NULL,
  `place_of_loading_code` VARCHAR(255) NULL,
  `session_num` VARCHAR(255) NULL,
  `session_role_name` VARCHAR(255) NULL,
  `status_of_entry` VARCHAR(255) NULL,
  `transport_country` VARCHAR(255) NULL,
  `transport_id` VARCHAR(255) NULL,
  `transport_mode_code` VARCHAR(45) NULL,
  `dispatch_country` VARCHAR(255) NULL,
  `consignor_turn_country_code` VARCHAR(45) NULL,
  `consignor_nad_name` VARCHAR(255) NULL,
  `consignee_nad_name` VARCHAR(255) NULL,
  `consignee_nad_postcode` VARCHAR(255) NULL,
  `declarant_nad_name` VARCHAR(255) NULL,
  `customs_check_code` VARCHAR(255) NULL,
  `profile_id` VARCHAR(255) NULL,
  `invoice_total_declared` VARCHAR(255) NULL,
  PRIMARY KEY (`hub_declaration_key`),
  CONSTRAINT `fk_sat_declaration_hub_declaration`
    FOREIGN KEY (`hub_declaration_key`)
    REFERENCES `DataVault`.`hub_declaration` (`hub_declaration_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_headers_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.sat_declaration_line
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`sat_declaration_line` (
  `hub_declaration_line_key` CHAR(32) NOT NULL,
  `sat_hash_diff` CHAR(32) NOT NULL,
  `sat_load_datetime` DATETIME NOT NULL,
  `sat_load_end_datetime` DATETIME NULL DEFAULT NULL,
  `sat_record_source` VARCHAR(255) NULL DEFAULT NULL,
  `clearance_datetime` VARCHAR(255) NULL DEFAULT NULL,
  `item_statistical_value` VARCHAR(255) NULL DEFAULT NULL,
  `customs_duty_paid` VARCHAR(255) NULL DEFAULT NULL,
  `vat_paid` VARCHAR(255) NULL DEFAULT NULL,
  `ec_supplementary_1` VARCHAR(255) NULL,
  `item_customs_value` VARCHAR(255) NULL,
  `item_net_mass` VARCHAR(255) NULL,
  `item_supplementary_units` VARCHAR(255) NULL,
  `goods_description` VARCHAR(45) NULL,
  `item_customs_check_code` VARCHAR(255) NULL,
  `item_mic_code` VARCHAR(255) NULL,
  `item_profile_id` VARCHAR(255) NULL,
  `item_consignor_nad_name` VARCHAR(255) NULL,
  `item_consignee_nad_name` VARCHAR(255) NULL,
  `item_consignee_nad_postcode` VARCHAR(255) NULL,
  `vat_value` VARCHAR(45) NULL,
  `item_price_declared` VARCHAR(255) NULL,
  PRIMARY KEY (`hub_declaration_line_key`),
  CONSTRAINT `fk_sat_declaration_line_hub_declaration_line`
    FOREIGN KEY (`hub_declaration_line_key`)
    REFERENCES `DataVault`.`hub_declaration_line` (`hub_declaration_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_lines_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.sat_trader
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`sat_trader` (
  `hub_trader_key` CHAR(32) NOT NULL,
  `sat_hash_diff` CHAR(32) NOT NULL,
  `sat_load_datetime` DATETIME NOT NULL,
  `sat_load_end_datetime` DATETIME NULL DEFAULT NULL,
  `sat_record_source` VARCHAR(255) NULL DEFAULT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `simplified_procedure_authorisations` VARCHAR(255) NULL DEFAULT NULL,
  `trader_name_abbreviated` VARCHAR(255) NULL,
  `currentind` VARCHAR(255) NULL,
  PRIMARY KEY (`hub_trader_key`),
  CONSTRAINT `fk_sat_trader_hub_trader`
    FOREIGN KEY (`hub_trader_key`)
    REFERENCES `DataVault`.`hub_trader` (`hub_trader_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_trader\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_exporter_trader
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_exporter_trader` (
  `link_declaration_exporter_trader_key` CHAR(32) NOT NULL,
  `hub_declaration_key` CHAR(32) NOT NULL,
  `hub_trader_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `turn` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"exporter_turn\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `fk_link_declaration_declarant_trader_hub_declaration` (`hub_declaration_key` ASC),
  INDEX `fk_link_declaration_declarant_trader_hub_trader` (`hub_trader_key` ASC),
  CONSTRAINT `fk_link_declaration_exporter_trader_hub_declaration`
    FOREIGN KEY (`hub_declaration_key`)
    REFERENCES `DataVault`.`hub_declaration` (`hub_declaration_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_exporter_trader_hub_trader`
    FOREIGN KEY (`hub_trader_key`)
    REFERENCES `DataVault`.`hub_trader` (`hub_trader_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration\",\n            \"table\": \"landing_headers_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_destination_country
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_destination_country` (
  `link_declaration_destination_country_key` CHAR(32) NOT NULL,
  `hub_declaration_key` CHAR(32) NOT NULL,
  `hub_country_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `iso_country_code_alpha_2` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"destination_country_code\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`link_declaration_destination_country_key`),
  INDEX `fk_link_declaration_line_origin_country_hub_country` (`hub_country_key` ASC),
  INDEX `fk_link_declaration_destination_country_hub_declaration1_idx` (`hub_declaration_key` ASC),
  CONSTRAINT `fk_link_declaration_line_origin_country_hub_country0`
    FOREIGN KEY (`hub_country_key`)
    REFERENCES `DataVault`.`hub_country` (`hub_country_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_destination_country_hub_declaration1`
    FOREIGN KEY (`hub_declaration_key`)
    REFERENCES `DataVault`.`hub_declaration` (`hub_declaration_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration\",\n            \"table\": \"landing_headers_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_paying_agent_trader
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_paying_agent_trader` (
  `link_declaration_paying_agent_trader_key` CHAR(32) NOT NULL,
  `hub_declaration_key` CHAR(32) NOT NULL,
  `hub_trader_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `turn` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"paying_agent_turn\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `fk_link_declaration_declarant_trader_hub_declaration` (`hub_declaration_key` ASC),
  INDEX `fk_link_declaration_declarant_trader_hub_trader` (`hub_trader_key` ASC),
  CONSTRAINT `fk_link_declaration_paying_agent_trader_hub_declaration`
    FOREIGN KEY (`hub_declaration_key`)
    REFERENCES `DataVault`.`hub_declaration` (`hub_declaration_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_paying_trader_hub_trader`
    FOREIGN KEY (`hub_trader_key`)
    REFERENCES `DataVault`.`hub_trader` (`hub_trader_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration\",\n            \"table\": \"landing_headers_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_transport_country
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_transport_country` (
  `link_declaration_destination_country_key` CHAR(32) NOT NULL,
  `hub_declaration_key` CHAR(32) NOT NULL,
  `hub_country_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `iso_country_code_alpha_2` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"transport_country\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`link_declaration_destination_country_key`),
  INDEX `fk_link_declaration_line_origin_country_hub_country` (`hub_country_key` ASC),
  INDEX `fk_link_declaration_destination_country_hub_declaration1_idx` (`hub_declaration_key` ASC),
  CONSTRAINT `fk_link_declaration_transport_country_hub_country`
    FOREIGN KEY (`hub_country_key`)
    REFERENCES `DataVault`.`hub_country` (`hub_country_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_transport_country_hub_declaration`
    FOREIGN KEY (`hub_declaration_key`)
    REFERENCES `DataVault`.`hub_declaration` (`hub_declaration_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration\",\n            \"table\": \"landing_headers_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_consignor_trader
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_consignor_trader` (
  `link_declaration_consignor_trader_key` CHAR(32) NOT NULL,
  `hub_declaration_key` CHAR(32) NOT NULL,
  `hub_trader_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `turn` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"consignor_turn\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `fk_link_declaration_declarant_trader_hub_declaration` (`hub_declaration_key` ASC),
  INDEX `fk_link_declaration_declarant_trader_hub_trader` (`hub_trader_key` ASC),
  CONSTRAINT `fk_link_declaration_consignor_trader_hub_declaration`
    FOREIGN KEY (`hub_declaration_key`)
    REFERENCES `DataVault`.`hub_declaration` (`hub_declaration_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_consignor_trader_hub_trader`
    FOREIGN KEY (`hub_trader_key`)
    REFERENCES `DataVault`.`hub_trader` (`hub_trader_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration\",\n            \"table\": \"landing_headers_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_line_importer_trader
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_line_importer_trader` (
  `link_declaration_line_importer_trader_key` CHAR(32) NOT NULL,
  `hub_declaration_line_key` CHAR(32) NOT NULL,
  `hub_trader_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `item_number` VARCHAR(255) NULL,
  `turn` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"item_importer_turn\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `fk_link_declaration_line_item_importer_hub_trader` (`hub_trader_key` ASC),
  INDEX `fk_link_declaration_line_importer_trader_hub_declaration_line` (`hub_declaration_line_key` ASC),
  CONSTRAINT `fk_link_declaration_line_item_importer_hub_trader`
    FOREIGN KEY (`hub_trader_key`)
    REFERENCES `DataVault`.`hub_trader` (`hub_trader_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_line_item_importer_hub_declaration_line`
    FOREIGN KEY (`hub_declaration_line_key`)
    REFERENCES `DataVault`.`hub_declaration_line` (`hub_declaration_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration_line\",\n            \"table\": \"landing_lines_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_line_document
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_line_document` (
  `link_declaration_line_document_key` CHAR(32) NOT NULL,
  `hub_declaration_line_key` CHAR(32) NOT NULL,
  `hub_document_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `item_number` VARCHAR(255) NULL DEFAULT NULL,
  `document_sequence_number` VARCHAR(255) NULL DEFAULT NULL,
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`link_declaration_line_document_key`),
  INDEX `fk_link_declaration_line_document_hub_document1_idx` (`hub_document_key` ASC),
  INDEX `fk_link_declaration_line_document_hub_declaration_line1_idx` (`hub_declaration_line_key` ASC),
  CONSTRAINT `fk_link_declaration_line_document_hub_document`
    FOREIGN KEY (`hub_document_key`)
    REFERENCES `DataVault`.`hub_document` (`hub_document_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_line_document_hub_declaration_line`
    FOREIGN KEY (`hub_declaration_line_key`)
    REFERENCES `DataVault`.`hub_declaration_line` (`hub_declaration_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_document\",\n            \"table\": \"landing_line_document\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.hub_document
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`hub_document` (
  `hub_document_key` CHAR(32) NOT NULL,
  `hub_load_datetime` DATETIME NOT NULL,
  `hub_record_source` VARCHAR(255) NOT NULL,
  `entry_reference` VARCHAR(255) NOT NULL,
  `item_number` VARCHAR(255) NOT NULL,
  `document_sequence_number` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`hub_document_key`, `hub_load_datetime`, `hub_record_source`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_line_document\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.sat_document
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`sat_document` (
  `hub_document_key` CHAR(32) NOT NULL,
  `sat_hash_diff` CHAR(32) NOT NULL,
  `sat_load_datetime` DATETIME NOT NULL,
  `sat_load_end_datetime` DATETIME NOT NULL,
  `sat_record_source` VARCHAR(255) NOT NULL,
  `generation_number` VARCHAR(255) NULL,
  `item_document_code` VARCHAR(255) NULL,
  `item_document_status` VARCHAR(255) NULL,
  `item_document_reference` VARCHAR(255) NULL,
  PRIMARY KEY (`hub_document_key`),
  CONSTRAINT `fk_sat_document_hub_document`
    FOREIGN KEY (`hub_document_key`)
    REFERENCES `DataVault`.`hub_document` (`hub_document_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_line_document\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_line_additional_info
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_line_additional_info` (
  `link_declaration_line_additional_info_key` CHAR(32) NOT NULL,
  `hub_declaration_line_key` CHAR(32) NOT NULL,
  `hub_additional_info_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `item_number` VARCHAR(255) NULL DEFAULT NULL,
  `additional_information_sequence_number` VARCHAR(255) NULL DEFAULT NULL,
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`link_declaration_line_additional_info_key`),
  INDEX `fk_link_declaration_line_additional_info_hub_declaration_li_idx` (`hub_declaration_line_key` ASC),
  INDEX `fk_link_declaration_line_additional_info_hub_additional_inf_idx` (`hub_additional_info_key` ASC),
  CONSTRAINT `fk_link_declaration_line_additional_info_hub_declaration_line`
    FOREIGN KEY (`hub_declaration_line_key`)
    REFERENCES `DataVault`.`hub_declaration_line` (`hub_declaration_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_line_additional_info_hub_additional_info`
    FOREIGN KEY (`hub_additional_info_key`)
    REFERENCES `DataVault`.`hub_additional_info` (`hub_additional_info_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_additional_info\",\n            \"table\": \"landing_line_additional_information\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.hub_additional_info
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`hub_additional_info` (
  `hub_additional_info_key` CHAR(32) NOT NULL,
  `hub_load_datetime` DATETIME NOT NULL,
  `hub_record_source` VARCHAR(255) NOT NULL,
  `entry_reference` VARCHAR(255) NOT NULL,
  `item_number` VARCHAR(255) NOT NULL,
  `additional_information_sequence_number` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`hub_additional_info_key`, `hub_load_datetime`, `hub_record_source`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_line_additional_information\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.sat_additional_info
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`sat_additional_info` (
  `hub_additional_info_key` CHAR(32) NOT NULL,
  `sat_hash_diff` CHAR(32) NOT NULL,
  `sat_load_datetime` DATETIME NOT NULL,
  `sat_load_end_datetime` DATETIME NOT NULL,
  `sat_record_source` VARCHAR(255) NOT NULL,
  `generation_number` VARCHAR(255) NULL,
  `additional_information_statement` VARCHAR(255) NULL,
  `additional_information_statement_type` VARCHAR(255) NULL,
  `item_additional_information_statement` VARCHAR(255) NULL,
  PRIMARY KEY (`hub_additional_info_key`),
  CONSTRAINT `fk_sat_additional_info_hub_additional_info`
    FOREIGN KEY (`hub_additional_info_key`)
    REFERENCES `DataVault`.`hub_additional_info` (`hub_additional_info_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_line_additional_information\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_line_tax_line
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_line_tax_line` (
  `link_declaration_line_tax_line_key` CHAR(32) NOT NULL,
  `hub_declaration_line_key` CHAR(32) NOT NULL,
  `hub_tax_line_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `item_number` VARCHAR(255) NULL DEFAULT NULL,
  `tax_line_sequence_number` VARCHAR(255) NULL DEFAULT NULL,
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`link_declaration_line_tax_line_key`),
  INDEX `fk_link_declaration_line_tax_line_hub_declaration_line1_idx` (`hub_declaration_line_key` ASC),
  INDEX `fk_link_declaration_line_tax_line_hub_tax_line1_idx` (`hub_tax_line_key` ASC),
  CONSTRAINT `fk_link_declaration_line_tax_line_hub_declaration_line`
    FOREIGN KEY (`hub_declaration_line_key`)
    REFERENCES `DataVault`.`hub_declaration_line` (`hub_declaration_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_line_tax_line_hub_tax_line`
    FOREIGN KEY (`hub_tax_line_key`)
    REFERENCES `DataVault`.`hub_tax_line` (`hub_tax_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_tax_line\",\n            \"table\": \"landing_line_tax_line\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.hub_tax_line
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`hub_tax_line` (
  `hub_tax_line_key` CHAR(32) NOT NULL,
  `hub_load_datetime` DATETIME NOT NULL,
  `hub_record_source` VARCHAR(255) NOT NULL,
  `entry_reference` VARCHAR(255) NOT NULL,
  `item_number` VARCHAR(255) NOT NULL,
  `tax_line_sequence_number` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`hub_tax_line_key`, `hub_load_datetime`, `hub_record_source`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_line_tax_line\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.sat_tax_line
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`sat_tax_line` (
  `hub_tax_line_key` CHAR(32) NOT NULL,
  `sat_hash_diff` CHAR(32) NOT NULL,
  `sat_load_datetime` DATETIME NOT NULL,
  `sat_load_end_datetime` DATETIME NOT NULL,
  `sat_record_source` VARCHAR(255) NOT NULL,
  `generation_number` VARCHAR(255) NULL,
  `waived_tax` VARCHAR(255) NULL,
  `method_of_payment_code` VARCHAR(255) NULL,
  `tax_amount` VARCHAR(255) NULL,
  `tax_type_code` VARCHAR(255) NULL,
  PRIMARY KEY (`hub_tax_line_key`),
  INDEX `fk_sat_tax_line_hub_tax_line_idx` (`hub_tax_line_key` ASC),
  CONSTRAINT `fk_sat_tax_line_hub_tax_line`
    FOREIGN KEY (`hub_tax_line_key`)
    REFERENCES `DataVault`.`hub_tax_line` (`hub_tax_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_line_tax_line\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.hub_currency
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`hub_currency` (
  `hub_currency_key` CHAR(32) NOT NULL,
  `currency_iso_code` CHAR(3) NOT NULL,
  `hub_load_datetime` DATETIME NOT NULL,
  `hub_record_source` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`hub_currency_key`, `hub_load_datetime`, `hub_record_source`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"dim_currency\",\n            \"record_source_field\": {\n                \"type\": \"literal\",\n                \"value\": \"dim_currency\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.sat_currency
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`sat_currency` (
  `hub_currency_key` CHAR(32) NOT NULL,
  `sat_hash_diff` CHAR(32) NOT NULL,
  `sat_load_datetime` DATETIME NULL DEFAULT NULL,
  `sat_load_end_datetime` DATETIME NOT NULL,
  `sat_record_source` VARCHAR(255) NULL DEFAULT NULL,
  `currency_name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`hub_currency_key`),
  CONSTRAINT `fk_sat_currency`
    FOREIGN KEY (`hub_currency_key`)
    REFERENCES `DataVault`.`hub_currency` (`hub_currency_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"dim_currency\",\n            \"record_source_field\": {\n                \"type\": \"literal\",\n                \"value\": \"dim_currency\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_freight_currency
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_freight_currency` (
  `link_declaration_freight_currency_key` CHAR(32) NOT NULL,
  `hub_declaration_key` CHAR(32) NOT NULL,
  `hub_currency_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `currency_iso_code` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"freight_currency\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `fk_link_declaration_declarant_trader_hub_declaration` (`hub_declaration_key` ASC),
  INDEX `fk_link_declaration_freight_currency_hub_currency_idx` (`hub_currency_key` ASC),
  CONSTRAINT `fk_link_declaration_freight_currency_hub_declaration`
    FOREIGN KEY (`hub_declaration_key`)
    REFERENCES `DataVault`.`hub_declaration` (`hub_declaration_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_freight_currency_hub_currency`
    FOREIGN KEY (`hub_currency_key`)
    REFERENCES `DataVault`.`hub_currency` (`hub_currency_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration\",\n            \"table\": \"landing_headers_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_invoice_currency
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_invoice_currency` (
  `link_declaration_freight_currency_key` CHAR(32) NOT NULL,
  `hub_declaration_key` CHAR(32) NOT NULL,
  `hub_currency_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `currency_iso_code` VARCHAR(255) NULL DEFAULT NULL COMMENT '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"field\": \"invoice_currency\"\n        }\n    }\n}',
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `fk_link_declaration_declarant_trader_hub_declaration` (`hub_declaration_key` ASC),
  INDEX `fk_link_declaration_freight_currency_hub_currency_idx` (`hub_currency_key` ASC),
  CONSTRAINT `fk_link_declaration_invoice_currency_hub_declaration`
    FOREIGN KEY (`hub_declaration_key`)
    REFERENCES `DataVault`.`hub_declaration` (`hub_declaration_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_invoice_currency_hub_currency`
    FOREIGN KEY (`hub_currency_key`)
    REFERENCES `DataVault`.`hub_currency` (`hub_currency_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_declaration\",\n            \"table\": \"landing_headers_declaration\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.sat_previous_document
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`sat_previous_document` (
  `hub_previous_document_key` CHAR(32) NOT NULL,
  `sat_hash_diff` CHAR(32) NOT NULL,
  `sat_load_datetime` DATETIME NOT NULL,
  `sat_load_end_datetime` DATETIME NOT NULL,
  `sat_record_source` VARCHAR(255) NOT NULL,
  `previous_document_reference` VARCHAR(255) NULL,
  PRIMARY KEY (`hub_previous_document_key`),
  CONSTRAINT `fk_sat_document_hub_document0`
    FOREIGN KEY (`hub_previous_document_key`)
    REFERENCES `DataVault`.`hub_previous_document` (`hub_previous_document_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_line_previous_document\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.hub_previous_document
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`hub_previous_document` (
  `hub_previous_document_key` CHAR(32) NOT NULL,
  `hub_load_datetime` DATETIME NOT NULL,
  `hub_record_source` VARCHAR(255) NOT NULL,
  `entry_reference` VARCHAR(255) NOT NULL,
  `item_number` VARCHAR(255) NOT NULL,
  `previous_document_sequence_number` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`hub_previous_document_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"table\": \"landing_line_previous_document\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';

-- ----------------------------------------------------------------------------
-- Table DataVault.link_declaration_line_previous_document
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataVault`.`link_declaration_line_previous_document` (
  `link_declaration_line_document_key` CHAR(32) NOT NULL,
  `hub_declaration_line_key` CHAR(32) NOT NULL,
  `hub_document_key` CHAR(32) NOT NULL,
  `entry_reference` VARCHAR(255) NULL DEFAULT NULL,
  `item_number` VARCHAR(255) NULL DEFAULT NULL,
  `previous_document_sequence_number` VARCHAR(255) NULL DEFAULT NULL,
  `link_load_datetime` DATETIME NULL DEFAULT NULL,
  `link_record_source` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`link_declaration_line_document_key`),
  INDEX `fk_link_declaration_line_document_hub_document1_idx` (`hub_document_key` ASC),
  INDEX `fk_link_declaration_line_document_hub_declaration_line1_idx` (`hub_declaration_line_key` ASC),
  CONSTRAINT `fk_link_declaration_line_document_hub_document0`
    FOREIGN KEY (`hub_document_key`)
    REFERENCES `DataVault`.`hub_previous_document` (`hub_previous_document_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_declaration_line_document_hub_declaration_line0`
    FOREIGN KEY (`hub_declaration_line_key`)
    REFERENCES `DataVault`.`hub_declaration_line` (`hub_declaration_line_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = '{\n    \"data_vault_population_metadata\": {\n        \"source\": {\n            \"hub\": \"hub_previous_document\",\n            \"table\": \"landing_line_previous_document\",\n            \"record_source_field\": {\n                \"type\": \"field\",\n                \"value\": \"source\"\n            }\n        }\n    }\n}';
SET FOREIGN_KEY_CHECKS = 1;
