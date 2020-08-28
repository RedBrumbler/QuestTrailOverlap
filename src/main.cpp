#include "../include/mod_interface.hpp"
#include <unordered_set>
#include "../extern/beatsaber-hook/shared/utils/utils.h"
#include "../extern/beatsaber-hook/shared/utils/logging.hpp"
#include "../extern/modloader/shared/modloader.hpp"
#include "../extern/beatsaber-hook/shared/utils/il2cpp-utils.hpp" 
#include "../extern/beatsaber-hook/shared/utils/il2cpp-functions.hpp"
#include "../extern/beatsaber-hook/shared/utils/typedefs.h"
#include "../extern/beatsaber-hook/shared/config/config-utils.hpp"
#include <string>

static ModInfo modInfo;
static const Logger& getLogger() {
    static const Logger logger(modInfo);
    return logger;
}

MAKE_HOOK_OFFSETLESS(ConditionalMaterialSwitcher_Awake, void, Il2CppObject* self)
{
    Il2CppObject* GO = CRASH_UNLESS(il2cpp_utils::GetPropertyValue(self, "gameObject"));
    std::string thisName = to_utf8(csstrtostr(CRASH_UNLESS(il2cpp_utils::GetPropertyValue<Il2CppString*>(GO, "name"))));
    if (thisName == "Trail(Clone)") return;
    ConditionalMaterialSwitcher_Awake(self);
}

extern "C" void setup(ModInfo& info) {

    info.id = "TrailOverlap";
    info.version = "0.1.0";
    modInfo = info;
}

extern "C" void load() {
    il2cpp_functions::Init();
    INSTALL_HOOK_OFFSETLESS(ConditionalMaterialSwitcher_Awake, il2cpp_utils::FindMethodUnsafe("", "ConditionalMaterialSwitcher", "Awake", 0)); 
    getLogger().info("Hooks installed");
}