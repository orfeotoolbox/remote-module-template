set(DOCUMENTATION "OTB module template.")

# itk_module() defines the module dependencies in ExternalTemplate
# ExternalTemplate depends on ITKCommon
# The testing module in ExternalTemplate depends on ITKTestKernel
# and ITKMetaIO(besides ExternalTemplate and ITKCore)
# By convention those modules outside of ITK are not prefixed with
# ITK.

# define the dependencies of the include module and the tests
otb_module(ExternalTemplate
  DEPENDS
    OTBCommon
    OTBApplicationEngine
  TEST_DEPENDS
    OTBTestKernel
    OTBImageIO
  DESCRIPTION
    "${DOCUMENTATION}"
)
