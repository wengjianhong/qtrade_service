add_test([=[ServiceSmoke.Placeholder]=]  /home/wengjianhong/GitSpace/qtrade_service/build/bin/qtrade_service_tests [==[--gtest_filter=ServiceSmoke.Placeholder]==] --gtest_also_run_disabled_tests)
set_tests_properties([=[ServiceSmoke.Placeholder]=]  PROPERTIES WORKING_DIRECTORY /home/wengjianhong/GitSpace/qtrade_service/build/test SKIP_REGULAR_EXPRESSION [==[\[  SKIPPED \]]==])
set(  qtrade_service_tests_TESTS ServiceSmoke.Placeholder)
