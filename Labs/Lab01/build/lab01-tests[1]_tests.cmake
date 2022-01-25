add_test( HelloTest.BasicAssertions /mnt/c/Users/jrd2112/source/repos/CMakeProject1/Labs/Lab01/build/lab01-tests [==[--gtest_filter=HelloTest.BasicAssertions]==] --gtest_also_run_disabled_tests)
set_tests_properties( HelloTest.BasicAssertions PROPERTIES WORKING_DIRECTORY /mnt/c/Users/jrd2112/source/repos/CMakeProject1/Labs/Lab01/build)
set( lab01-tests_TESTS HelloTest.BasicAssertions)
