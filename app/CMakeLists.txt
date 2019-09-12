
# This macro creates the application EmptyApp. It must be linked to
# OTBApplicationEngine. Since the module has its own library,
# the variable ${otb-module}_LIBRARIES only contains this library, which doesn't
# drag OTBApplicationEngine, so we need to add it explicitely.
OTB_CREATE_APPLICATION(NAME EmptyApp
                       SOURCES otbEmptyApp.cxx
                       LINK_LIBRARIES ${${otb-module}_LIBRARIES} ${OTBApplicationEngine_LIBRARIES}
)
