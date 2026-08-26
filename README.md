# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore
## Mod-AHBOT
- Latest build status with azerothcore: [![Build Status](https://github.com/azerothcore/mod-ah-bot/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-ah-bot)


## Important notes

You have to use at least AzerothCore commit [9adba48](https://github.com/azerothcore/azerothcore-wotlk/commit/9adba482c236f1087d66a672e97a99f763ba74b3).

If you use an old version of this module please update the table structure using this SQL statement:

```sql
ALTER TABLE `auctionhousebot` RENAME TO `mod_auctionhousebot`;
```

## Description

An auction house bot for the best core: AzerothCore.
This mod works by selling and bidding auctions in the factions auction house. It can be instructed to do both the operations independently.

## Installation

```
1. Simply place the module under the `modules` directory of your AzerothCore source.
1. Import the SQL manually to the right Database (auth, world or characters).
1. Re-run cmake and launch a clean build of AzerothCore.
```

## Usage

Edit the module configuration and add a player account ID and a character ID.
This character will sell and buy items in the auction house so give him a good name.
If you only specify the account ID, all the characters created within that account will be involved in selling and bidding on the markets.

Specify what operation must be performed (`EnableSeller`, `EnableBuyer` or both).

Notes:
- The account used does not need any security level and can be a player account.
- The character used by the ahbot is not meant to be used ingame. If you use it to browse the auction house, you might have issues like "Searching for items..." displaying forever.

### Authoritative per-item seller prices

Import `data/sql/db-world/mod_auctionhousebot_item_prices.sql`, followed by `mod_auctionhousebot_item_prices_phase2_seed.sql`. The Phase 2 catalog is complete: it contains one generic rule for every one of the 46,096 official AzerothCore 3.3.5 item templates, plus exact faction-auction-house overrides where required. Legitimate Phase 2 market goods are enabled; later-phase, soulbound, promotional, event-only, test, and otherwise unsafe items are retained as explicit disabled rules instead of being omitted.

The catalog is pinned to AzerothCore commit [`a1757524`](https://github.com/azerothcore/azerothcore-wotlk/commit/a175752440b31de34f1a8a1469f71d2d2c1ad994). Prices use archived April-June 2023 WotLK Classic auction observations where they are trustworthy, then vendor, crafting, conversion, category, and rarity floors. Thin-market outliers are capped, while curated raid-BoE, rare-mount, and collector-world-drop overrides take priority.

Use these values in `mod_ahbot.conf` to make the table the seller's source of truth (they are also the supplied defaults):

```ini
AuctionHouseBot.ItemPriceTableMode = 2
AuctionHouseBot.CurrentPhase = 2
```

Mode `2` is strict: only enabled table rows may be listed, so new or custom item templates fail closed until an administrator adds a price rule. Mode `1` is hybrid: a matching table row is authoritative, while unlisted items retain legacy pricing. Mode `0` disables the feature.

Prices in `buyout_copper` are final per-unit buyouts. The quality and learned-market multipliers are not applied to them. A row with `enabled=0` explicitly prevents the item from being listed, including in hybrid mode. Auction-house `0` is the generic rule; a row for house `2`, `6`, or `7` overrides it for that house.

The supplied seed is a canonical Phase 2 replacement: importing it removes existing Phase 2 generic and house-specific rules before inserting the complete catalog. Back up any local Phase 2 overrides you intend to reapply.

`max_bot_auctions` counts concurrent listings from all configured bot characters in the affected auction house. It does not impose a cooldown after a sale. `force_include=1` lets a hybrid rule bypass legacy source, disabled-item, and whitelist filters; binding and other item-safety filters still apply. The buyer continues to use the legacy pricing path.

Configuration reloads rebuild both the price-rule map and seller bins, so phase or enablement changes do not require deleting existing module data. Existing auctions are left to expire normally.

## Edit module configuration (optional)

If you need to change the module configuration, go to your server configuration folder (where your `worldserver` or `worldserver.exe` is) in `modules` you will have to copy and rename (the copy) the file `mod_ahbot.conf.dist` to `mod_ahbot.conf` and edit it. This will change the overall behavior of the bot.

If you need to change a more specific value (for example the quotas of item sold), you will need to update values int the `mod_auctionhousebot` table or use the command line.

The default quotas of all the auction houses for trade goods are:
- Gray = 0
- White = 27
- Green = 12
- Blue = 10
- Purple = 1
- Orange = 0
- Yellow = 0

The default quotas of all the auction houses for non trade goods items are:
- Gray = 0
- White = 10
- Green = 30
- Blue = 8
- Purple = 2
- Orange = 0
- Yellow = 0

The sum of the percentage for these categories must always be 100, or otherwise the defaults values will be used and the modifications will not be accepted.

## Credits

- Ayase: ported the bot to AzerothCore
- Other contributors (check the contributors list)
