### Chef Sugar is being deprecated, this is the internal list of the TODO tasks

TASKS in order:

* ~~pull cloud.rb into core-chef~~
* pull data_bag.rb into core-chef
* ~~pull run_context.rb into core-chef~~
* ~~pull vagrant.rb into core-chef~~
* ~~pull virtualization.rb into core-chef~~
* deprecate ip.rb with no replacement (although maybe a new ohai attribute?)
* deprecate kernel.rb with no replacement
* ~~deprecate node.rb with no replacement~~
* deprecate ruby.rb with no replacement
* determine what to do about filters.rb
* determine what to do about remaining platform.rb
* determine what to do about shell.rb
* determine what to do about core_extensions

NOTES on files:

architecture.rb is COMPLETED

cloud.rb is COMPLETED

constraint.rb / constraint_dsl.rb tasks:

* replace with Chef::VersionString objects

core_extensions

* pile of monkeypatches that makes my eyes twitch a little bit.  how much do we want to become activerecord?  counter-argument is
  that some activerecord-ish helpers are SUUUPER useful.  but we should probably copy them from activerecord since those are more
  likely to get pulled directly into core-chef.

data_bag

* we should pull this into core-chef or something comparable (TBD)

docker.rb is COMPLETED

filters.rb tasks

* incorporate the before/after syntax into the find_resource/edit_resource API (probably renamed, with deprecation done here)
* deprecate the at_compile_time helper in favor of moving the `compile_time true` property into Chef::Resource directly

init.rb is COMPLETED

* unless we get user complaints, runit is dead to us and this is done

ip.rb

* needs to be deprecated with no replacement (could push this into another ohai attribute -- or have we done it already?)

kernel.rb (the require_chef_gem trivial helper)

* needs to be deprecated with no replacement.

kitchen.rb is COMPLETED

node.rb (the method_missing syntax)

* needs to be deprecated with no replacement.

platform.rb tasks:

* decide what to do about the `debian_before_squeeze` platform version helpers.
* decide what to do about the `platform_version` helper (can we wire this up to a Chef::VersionString object instead?)

platform_family.rb is COMPLETED

ruby.rb tasks:

* needs to be deprecated with no replacement (nobody has used it since ruby 2.0, so its clearly not being used)

run_context.rb is COMPLETED

shell.rb: (collection of helpers including `which`)

* TBD

vagrant.rb is COMPLETED

virtualization.rb is COMPLETED

