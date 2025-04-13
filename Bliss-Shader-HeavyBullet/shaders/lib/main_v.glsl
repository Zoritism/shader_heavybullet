#include "/settings.glsl"

#if FLASH_LIGHT > 0
uniform vec3 flashlightDirection; // Направление света
#endif

void main() {
    // Существующий код...

    #if FLASH_LIGHT > 0
    vec3 flashlightDir = normalize(flashlightDirection);
    // Логика для обработки направленного света фонарика
    #endif
}