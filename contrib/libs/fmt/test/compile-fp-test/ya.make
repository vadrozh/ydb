# Generated by devtools/yamaker.

GTEST()

WITHOUT_LICENSE_TEXTS()

LICENSE(MIT)

ADDINCL(
    contrib/libs/fmt/include
)

NO_COMPILER_WARNINGS()

NO_UTIL()

CFLAGS(
    -DFMT_HEADER_ONLY=1
    -DGTEST_HAS_STD_WSTRING=1
    -D_SILENCE_TR1_NAMESPACE_DEPRECATION_WARNING=1
)

LICENSE_RESTRICTION_EXCEPTIONS(contrib/libs/fmt)

SRCDIR(contrib/libs/fmt)

SRCS(
    src/os.cc
    test/compile-fp-test.cc
    test/gtest-extra.cc
    test/util.cc
)

END()
