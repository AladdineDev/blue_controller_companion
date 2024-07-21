// ignore_for_file: constant_identifier_names

enum ControllerButton {
  L1(command: 0x1),
  R1(command: 0x2),
  L2(command: 0x3),
  R2(command: 0x4),
  L3(command: 0x5),
  R3(command: 0x6),
  CROSS(command: 0x7),
  SQUARE(command: 0x8),
  CIRCLE(command: 0x9),
  TRIANGLE(command: 0xa),
  UP(command: 0xb),
  DOWN(command: 0xc),
  LEFT(command: 0xd),
  RIGHT(command: 0xe),
  START(command: 0xf),
  OPTIONS(command: 0x10);

  const ControllerButton({required this.command});

  final int command;
}
