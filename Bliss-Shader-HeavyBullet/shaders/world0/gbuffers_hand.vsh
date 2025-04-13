#version 120

#define WORLD
#define HAND

#define OVERWORLD_SHADER

#include "/dimensions/all_solid.vsh"

// Встроенный код из shader_flashlighttest
#include "/main_v.glsl"

```
Новый файл теперь совмещает оригинальный функционал из `shader_heavybullet` и включает подключение `main_v.glsl` из `shader_flashlighttest`. Если требуются дополнительные изменения или уточнения, дайте знать!