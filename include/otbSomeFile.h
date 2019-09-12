#ifndef otbSomeFile_h
#define otbSomeFile_h

// this header defines export macros, such as ExternalTemplate_EXPORT.
// On Windows, it is replaced by declspec import/export
#include "ExternalTemplateExport.h"

namespace otb {

ExternalTemplate_EXPORT void ThisFunctionDoesNothing();

}

#endif
