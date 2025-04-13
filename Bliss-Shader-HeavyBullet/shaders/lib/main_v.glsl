#include "settings.glsl"
#include "dual_distort.glsl" // Подключение функции dual_distort

#if FLASH_LIGHT > 0
uniform vec3 flashlightDirection; // Направление света фонарика
uniform vec3 cameraPosition;      // Позиция камеры
#endif

// Передача данных из вершинного шейдера в фрагментный
out vec3 distortedPosition; // Искажённая позиция
out vec3 normal;            // Нормаль вершины
out vec3 tangent;           // Тангенс вершины
out mat3 normalMat;         // Нормальная матрица для преобразований

void main() {
    // Основной код вершины
    vec4 worldPosition = gl_ModelViewMatrix * gl_Vertex;

    #if FLASH_LIGHT > 0
    vec3 flashlightDir = normalize(flashlightDirection);

    // Применение dual_distort для искажения позиции
    distortedPosition = dual_distort(worldPosition.xyz);
    #else
    distortedPosition = worldPosition.xyz; // Используем обычную позицию, если фонарик отключен
    #endif

    // Пример расчёта нормали (замените на реальный код, если он другой)
    normal = normalize(gl_NormalMatrix * gl_Normal);

    // Пример тангенса (замените на реальный код, если он другой)
    tangent = vec3(1.0, 0.0, 0.0);

    // Пример нормальной матрицы (замените на реальный код, если он другой)
    normalMat = mat3(gl_ModelViewMatrix);

    // Передача финальной позиции вершины
    gl_Position = gl_ProjectionMatrix * vec4(distortedPosition, 1.0);
}