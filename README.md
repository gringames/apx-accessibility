# 🎮 APX Accessibility Godot Plugin
A first iteration of a Godot plugin for game accessibility based on the [Accessible Player Experience (APX) design patterns](https://accessible.games/accessible-player-experiences/) proposed by the AbleGamers Foundation.
Our goal is to make accessibility in games more achievable for game developers by providing concrete implementations for existing game accessibility guidelines.


## 📌 Overview
The plugin provides implementations for 4 APX patterns (not covered by other plugins). All information about the design patterns is taken from the [APX website](https://accessible.games/accessible-player-experiences/).

### Clear Channels (Visual Simplifications)
The Access pattern "Clear Channels" focuses on understanding information from certain channels, emphasising visual complexity [[Source](https://accessible.games/accessible-player-experiences/clear-channels)].
The provided implementation concentrates on visual simplifications and features:
- A sample menu with a check button for visual complexity reduction.<br>
<img width="275" height="57" alt="visual sample menu. Check button labled 'reduce visual complexity'" src="https://github.com/user-attachments/assets/77fac2d2-47a3-4c50-adbe-b865f10f360d"/>

- A ``VisualSimplifier`` node class: specify a node group, all nodes in that group are hidden when visual complexity reduction is enabled.
- A ``SimplifiableSprite2D`` node class: extends ``Sprite2D``, specify a second texture that is used when visual complexity reduction is enabled.
- A ``SimplifiableAnimatedSprite2D`` node class: extends ``AnimatedSprite2D``, specify a frame of an animation that is used when visual complexity reduction is enabled.
- A ``SimplifiableAnimationPlayer`` node class: extends ``AnimationPlayer``, specify an animation track that is used when visual complexity reduction is enabled.

Example scenery with visual complexity reduction is disabled (left) and enabled (right):<br>
<img width="400" height="216" alt="scenery without visual complexity reduction: player plays animation, background image uses normal texture, decorative elements are visible" src="https://github.com/user-attachments/assets/86b832a4-81bf-4015-a2c6-a7b8f853d6ab"/>
<img width="400" height="216" alt="scenery without visual complexity reduction: player shows a static frame of its animation, background image uses simplifed texture, decorative elements are hidden" src="https://github.com/user-attachments/assets/c85a168c-8a93-47f7-b9ba-6c22c737ebe0"/>


### Clear Text
The Access pattern "Clear Text" demands customisation options for game text presentation like colours and size [[Source](https://accessible.games/accessible-player-experiences/clear-text)].
The plugin provides a scene ``TextThemeEditor`` where players can make changes to a theme set in the inspector:<br>
<img width="300" height="377" alt="Text Theme Editor menu: lets the player select font, font size, line spacing, font and background color with auto-contrast, and background margins. Shows a preview text at the bottom" src="https://github.com/user-attachments/assets/5f1d207b-437b-4038-ad4b-bcc519b133ef"/>


### Same Controls But Different
The Access pattern "Same Controls But Different" postulates configurable interaction modes, defining whether an input action needs to be held or toggled [[Source](https://accessible.games/accessible-player-experiences/same-controls-but-different)].
The plugin features:
- A ``Hold/Toggle Settings`` scene: in-game menu where players can switch between hold and toggle for input actions set in the inspector.
- An ``InputHoldToggleManager`` autoload: used to query whether an input action is currently active, depending on its input mode.<br>
<img width="250" height="101" alt="hold_toggle_settings_scene" src="https://github.com/user-attachments/assets/af2af68d-6c30-4be5-9e48-3d476914044e"/>

### Total Recall
The Challenge pattern "Total Recall" addresses the problem that players might forget the controls or objectives of the game [[Source](https://accessible.games/accessible-player-experiences/total-recall)].
The plugin contains:
- A ``ControlsReminder`` node class: ``Sprite2D`` that shows on button press and can hold a controls image.
- A ``ObjectiveDisplay`` scene: lists the current and completed objectives in two respective tabs with buttons on the left showing the objective titles and displaying further information on the right when clicked.<br>
<img width="400" height="220" alt="Objective display scene: Shows example objectives in the 'Completed' tab and displays title and description with an image of the selected objective on the right" src="https://github.com/user-attachments/assets/29d63306-a334-4ca1-aa2a-3fb84dfdebd8"/>


## 🚀 Getting Started
Clone the whole repo or only the add-on you want to use. The sample menu for visual complexity reduction is in the ``samples`` folder.
