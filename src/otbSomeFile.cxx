#include "otbLogger.h"
#include "otbSomeFile.h"

namespace otb {

void ThisFunctionDoesNothing()
{
  Logger::Instance()->Info("This function does nothing\n");
}

}
