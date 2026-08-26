--
-- Curated Phase 2 authoritative item prices.
--
-- Prices are per unit in copper. Auction house 0 applies each rule to all
-- auction houses. Active rows use force_include=1 so zero-vendor-price and
-- custom-source items can enter the seller bins. Disabled rows remain as
-- explicit rules and therefore cannot fall through to legacy pricing.
--

INSERT INTO `mod_auctionhousebot_item_prices`
  (`item_id`, `phase`, `auctionhouse`, `enabled`, `buyout_copper`,
   `bid_pct`, `max_bot_auctions`, `max_stack`, `force_include`, `note`)
VALUES
  (40474, 2, 0, 1, 15030000, 100, 1, 1, 1,
   'Surge Needle Ring | Raid BoE | confidence: High | Phase market -> decay | Malygos/Tier 7 BoE; available from Phase 1'),
  (40558, 2, 0, 1, 11180000, 100, 1, 1, 1,
   'Arcanic Tramplers | Raid BoE | confidence: High | Phase market -> decay | Malygos/Tier 7 BoE; available from Phase 1'),
  (45247, 2, 0, 1, 45100000, 100, 1, 1, 1,
   'Signet of the Earthshaker | Raid BoE | confidence: High | T8/T9 markets -> decay | Ulduar/Tier 8 BoE; available from Phase 2'),
  (45291, 2, 0, 1, 8640000, 100, 1, 1, 1,
   'Combustion Bracers | Raid BoE | confidence: High | Phase-matched markets | Ulduar/Tier 8 BoE; available from Phase 2'),
  (50452, 2, 0, 0, 0, 100, 1, 1, 0,
   'Wodin''s Lucky Necklace | Raid BoE | confidence: Medium | T10 market + floor | ICC trash BoE; available from Phase 4'),
  (44413, 2, 0, 1, 169880000, 100, 1, 1, 1,
   'Mekgineer''s Chopper | Tradable mount | confidence: High | WotLK median + craft floor | Crafted WotLK mount; Alliance version (Horde analog: item 41508)'),
  (52200, 2, 0, 0, 0, 100, 1, 1, 0,
   'Reins of the Crimson Deathcharger | Tradable mount | confidence: Medium | T10 market + rarity floor | ICC/Shadowmourne chest reward; available from Phase 4'),
  (49282, 2, 0, 0, 750000000, 100, 1, 1, 0,
   'Big Battle Bear | Tradable mount | confidence: Low | Manual rarity floor; disabled | TCG/custom-source item; no normal WotLK acquisition route'),
  (49290, 2, 0, 0, 2000000000, 100, 1, 1, 0,
   'Magic Rooster Egg | Tradable mount | confidence: Low | Manual rarity floor; disabled | TCG/custom-source item; no normal WotLK acquisition route'),
  (1728, 2, 0, 1, 83930000, 100, 1, 1, 1,
   'Teebu''s Blazing Longsword | Collector/world drop | confidence: Medium | Robust WotLK median + floor | Extremely rare Vanilla world drop; cosmetic/collector demand'),
  (9425, 2, 0, 1, 3360000, 100, 1, 1, 1,
   'Pendulum of Doom | Collector/world drop | confidence: Low | Robust WotLK median + floor | Ultra-rare Uldaman world drop; collector market is thin'),
  (14970, 2, 0, 1, 5790000, 100, 1, 1, 1,
   'Glorious Legplates | Collector/world drop | confidence: Medium | Robust WotLK median + floor | Rare world-drop plate; random suffixes are pooled by item ID'),
  (1482, 2, 0, 1, 3570000, 100, 1, 1, 1,
   'Shadowfang | Collector/world drop | confidence: Medium | Robust WotLK median + floor | Rare Shadowfang Keep drop; twink and collector demand'),
  (37835, 2, 0, 1, 15030000, 100, 1, 1, 1,
   'Je''Tze''s Bell | Collector/world drop | confidence: High | Phase market + decay + floor | Northrend world epic; functional caster trinket'),
  (44308, 2, 0, 1, 11560000, 100, 1, 1, 1,
   'Signet of Edward the Odd | Collector/world drop | confidence: High | Phase market + decay + floor | Northrend world epic; functional melee ring'),
  (8494, 2, 0, 1, 43860000, 100, 1, 1, 1,
   'Parrot Cage (Hyacinth Macaw) | Collector/world drop | confidence: High | Robust WotLK median + floor | Rare Stranglethorn world-drop companion'),
  (29960, 2, 0, 1, 44620000, 100, 1, 1, 1,
   'Captured Firefly | Collector/world drop | confidence: High | 3-source median; outlier excluded | Rare Zangarmarsh world-drop companion'),
  (1973, 2, 0, 1, 3950000, 100, 1, 1, 1,
   'Orb of Deception | Collector/world drop | confidence: High | Robust WotLK median + floor | Rare world-drop transformation toy')
ON DUPLICATE KEY UPDATE
  `enabled` = VALUES(`enabled`),
  `buyout_copper` = VALUES(`buyout_copper`),
  `bid_pct` = VALUES(`bid_pct`),
  `max_bot_auctions` = VALUES(`max_bot_auctions`),
  `max_stack` = VALUES(`max_stack`),
  `force_include` = VALUES(`force_include`),
  `note` = VALUES(`note`);
