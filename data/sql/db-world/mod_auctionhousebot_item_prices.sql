--
-- Authoritative per-item seller prices.
--
-- This table is intentionally created without dropping or replacing an
-- existing table so that locally curated prices survive module updates.
-- Prices are stored per unit in copper. An auction's final price is the
-- per-unit value multiplied by its stack size.
--

CREATE TABLE IF NOT EXISTS `mod_auctionhousebot_item_prices` (
  `item_id` mediumint(8) unsigned NOT NULL
    COMMENT 'Item template entry.',
  `phase` tinyint(3) unsigned NOT NULL DEFAULT '1'
    COMMENT 'WotLK content phase selected by AuctionHouseBot.CurrentPhase.',
  `auctionhouse` tinyint(3) unsigned NOT NULL DEFAULT '0'
    COMMENT '0 applies to all houses; 2 Alliance, 6 Horde, 7 Neutral.',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1'
    COMMENT '0 explicitly prevents this item from being listed.',
  `buyout_copper` bigint(20) unsigned NOT NULL DEFAULT '0'
    COMMENT 'Authoritative per-unit buyout; must be positive when enabled.',
  `bid_pct` tinyint(3) unsigned NOT NULL DEFAULT '100'
    COMMENT 'Starting bid as a percentage of the authoritative buyout.',
  `max_bot_auctions` smallint(5) unsigned NOT NULL DEFAULT '1'
    COMMENT 'Maximum bot-owned auctions for this item; 0 means unlimited.',
  `max_stack` smallint(5) unsigned NOT NULL DEFAULT '1'
    COMMENT 'Maximum stack for this rule; 0 retains legacy stack handling.',
  `force_include` tinyint(1) unsigned NOT NULL DEFAULT '0'
    COMMENT 'In hybrid mode, bypass legacy source, disabled-item, and whitelist filters.',
  `note` varchar(255) DEFAULT NULL
    COMMENT 'Optional administrator note; ignored by the bot.',
  PRIMARY KEY (`item_id`, `phase`, `auctionhouse`),
  KEY `idx_ahbot_item_prices_load` (`phase`, `auctionhouse`, `enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
  COMMENT='Authoritative per-item AuctionHouseBot seller prices';
