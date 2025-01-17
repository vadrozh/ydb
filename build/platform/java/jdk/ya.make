RESOURCES_LIBRARY()

IF(USE_SYSTEM_JDK)
    MESSAGE(WARNING DEFAULT_JDK are disabled)
ELSEIF(JDK_REAL_VERSION == "20")
    DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE_BY_JSON(JDK_DEFAULT jdk20/jdk.json)
    SET_RESOURCE_URI_FROM_JSON(WITH_JDK_URI jdk20/jdk.json)
ELSEIF(JDK_REAL_VERSION == "19")
    DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE_BY_JSON(JDK_DEFAULT jdk19/jdk.json)
    SET_RESOURCE_URI_FROM_JSON(WITH_JDK_URI jdk19/jdk.json)
ELSEIF(JDK_REAL_VERSION == "18")
    DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE_BY_JSON(JDK_DEFAULT jdk18/jdk.json)
    SET_RESOURCE_URI_FROM_JSON(WITH_JDK_URI jdk18/jdk.json)
ELSEIF(JDK_REAL_VERSION == "17")
    DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE_BY_JSON(JDK_DEFAULT jdk17/jdk.json)
    SET_RESOURCE_URI_FROM_JSON(WITH_JDK_URI jdk17/jdk.json)
ELSEIF(JDK_REAL_VERSION == "16")
    DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE_BY_JSON(JDK_DEFAULT jdk16/jdk.json)
    SET_RESOURCE_URI_FROM_JSON(WITH_JDK_URI jdk16/jdk.json)
ELSEIF(JDK_REAL_VERSION == "15")
    DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE_BY_JSON(JDK_DEFAULT jdk15/jdk.json)
    SET_RESOURCE_URI_FROM_JSON(WITH_JDK_URI jdk15/jdk.json)
ELSEIF(JDK_REAL_VERSION == "11")
    DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE_BY_JSON(JDK_DEFAULT jdk11/jdk.json)
    SET_RESOURCE_URI_FROM_JSON(WITH_JDK_URI jdk11/jdk.json)
ELSEIF(JDK_REAL_VERSION == "10")
    DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE_BY_JSON(JDK_DEFAULT jdk10/jdk.json)
    SET_RESOURCE_URI_FROM_JSON(WITH_JDK_URI jdk10/jdk.json)
ELSEIF(JDK_REAL_VERSION == "8")
    DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE_BY_JSON(JDK_DEFAULT jdk8/jdk.json)
    SET_RESOURCE_URI_FROM_JSON(WITH_JDK_URI jdk8/jdk.json)
ELSE()
    MESSAGE(FATAL_ERROR Unsupported JDK version ${JDK_REAL_VERSION})
ENDIF()

IF (WITH_JDK_URI)
    DECLARE_EXTERNAL_RESOURCE(WITH_JDK ${WITH_JDK_URI})
ENDIF()

END()

RECURSE(
    jdk8
    jdk10
    jdk11
    jdk15
    jdk16
    jdk17
    jdk18
    jdk19
    jdk20
)
