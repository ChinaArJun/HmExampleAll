# HarmonyOS Skills 使用说明

这份说明覆盖你安装的 4 个 HarmonyOS/ArkTS 相关技能，并附带一个项目内的演示页面，方便直接体验效果。

## 已安装技能

1. harmonyos-app
HarmonyOS 应用开发全流程指导，覆盖 ArkTS、ArkUI、Stage 模型、分布式能力与最佳实践。
示例提示词：
```text
使用 harmonyos-app：请用 ArkTS + ArkUI 写一个 Stage 模型页面，展示商品卡片列表，并遵守 ArkTS 严格类型规则。
```

2. arkts-development
ArkTS 开发与 ArkUI 组件编写实战指南，包含状态管理、路由、网络、存储等常用场景。
示例提示词：
```text
使用 arkts-development：把一个 TS 示例组件改成 ArkTS，注意禁用 any 和动态属性访问。
```

3. arkui-api-design
ArkUI API 设计规范与静态/动态接口同步要求，适合做组件 API 设计与审查。
示例提示词：
```text
使用 arkui-api-design：帮我为一个自定义组件设计 ArkUI API，并给出 static 与 dynamic 的对照定义。
```

4. openharmony-arkts-utils
OpenHarmony ArkTS 工具库速查，覆盖 TaskPool、Worker、Sendable、XML、Buffer、JSON 与容器等。
示例提示词：
```text
使用 openharmony-arkts-utils：用 TaskPool 写一个并发计算示例，并解释限制条件。
```

提示：安装新技能后需要重启 Codex 才能加载。

## Demo 说明

我在项目内新增了一个演示页面，展示 TaskPool 并发计算的简单用法。

入口页面：
- 页签："鸿蒙-7. Skills Demo"
- 路径：pages/SkillDemo

演示内容：
- 使用 @Concurrent + taskpool.Task 在后台线程计算 1..N 的累加和
- 在 UI 中展示执行耗时与结果

文件位置：
- /Users/mac/code/hm/HmExampleAll/entry/src/main/ets/pages/SkillDemo.ets

如果需要扩展更多 demo，可以在该页面继续追加 TaskGroup、Worker 或 Sendable 示例。

## 更多组件示例

新增了两个示例页面，覆盖官方 ArkUI 文档中的常见组件与容器组件：

- 组件进阶（Radio / Checkbox / Progress / TextArea）
  - 路径：pages/ComponentAdvanced
- 布局与导航（Tabs / Swiper / Grid）
  - 路径：pages/LayoutNavigation
