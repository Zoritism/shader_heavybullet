#include "/settings.glsl"
#include "/dual_distort.glsl" // Подключение функции dual_distort

#if FLASH_LIGHT > 0
uniform vec3 flashlightDirection; // Направление света фонарика
uniform vec3 cameraPosition;      // Позиция камеры
#endif

varying vec3 distortedPosition; // Переменная для хранения искажённой позиции

void main() {
    // Основной код вершины
    vec4 worldPosition = gl_ModelViewMatrix * gl_Vertex;

    #if FLASH_LIGHT > 0
    vec3 flashlightDir = normalize(flashlightDirection);

    // Применение dual_distort для искажения позиции
    distortedPosition = dual_distort(worldPosition.xyz);
    #endif

    // Передача финальной позиции вершины
    gl_Position = gl_ProjectionMatrix * vec4(distortedPosition, 1.0);
}