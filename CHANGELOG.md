Chef Sugar Changelog
=========================
This file is used to list changes made in each version of the chef-sugar cookbook and gem.

v1.2.0 (2014-03-09)
-------------------
- Add `namespace` functionality for specifying attributes in a DSL
- Add constraints helpers for comparing version strings
- Add `require_chef_gem` to safely require and degrade if a gem is not installed
- Add `deep_fetch` and `deep_fetch!` to fetch deeply nested keys
- Accept an optional secret key in `encrypted_data_bag_item` helper and raise a helpful error if one is not set (NOTE: this changes the airity of the method, but it's backward-compatible because Ruby is magic)
- Add Stove for releasing
- Updated copyrights for 2014

v1.1.0 (2013-12-10)
-------------------
- Add `cloudstack?` helper
- Add data bag helpers
- Remove foodcritic checks
- Upgrade development gem versions
- Randomize spec order

v1.0.1 (2013-10-15)
-------------------
- Add development recipe
- Add `compile_time`, `before`, and `after` filters

v1.0.0 (2013-10-15)
-------------------
- First public release
