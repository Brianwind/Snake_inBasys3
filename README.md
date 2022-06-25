# Snake_inBasys3
The classic Snake game, written in `verilog`.

It runs on **Basys3** and comes with **2-player mode** and **mist mode**.
(The mist mode are **only** available in single player version at present.)

This project is licensed under MIT.

## File Structure

The description below shows the file structure of the 2-player version of the game. The file structure of the single player version is the same.

- my_snake.srcs
  - constrs_1/new
    - my_snake.xdc    `constraint file`
  - sources_1/new
    - Game_ctrl.v     `game status control unit`
    - Keyboard.v      `keyboard input unit`
    - Snake.v         `main logic for snake behavior`
    - Snake_food.v    `food location generation unit`
    - Snake_top.v     `sub-top file that connects game logic units`
    - VGA.v           `display drive and VGA signal generation unit`
    - my_snake_top.v  `top structure`
    - print_num.v     `number display unit`
