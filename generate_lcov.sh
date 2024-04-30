flutter test --coverage
lcov --remove coverage/lcov.info 'lib/utils/*' 'lib/core/data/datasource/*' -o coverage/new_lcov.info
genhtml coverage/new_lcov.info --output=coverage
open coverage/index.html