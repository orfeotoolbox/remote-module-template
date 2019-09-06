OTB_CREATE_APPLICATION(NAME EmptyApp
                       SOURCES otbEmptyApp.cxx
                       LINK_LIBRARIES ${${otb-module}_LIBRARIES} ${OTBApplicationEngine_LIBRARIES}
)





