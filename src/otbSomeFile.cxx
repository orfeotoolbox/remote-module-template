#include "otbLogger.h"

namespace otb {

void ThisFunctionDoesNothing()
{
  Logger::Instance()->Info("This function does nothing\n");
}

}
