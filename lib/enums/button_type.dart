// ignore_for_file: constant_identifier_names

enum ButtonType {
  CROSS(command: 0x1),
  CIRCLE(command: 0x2),
  SQUARE(command: 0x3),
  TRIANGLE(command: 0x4),
  L1(command: 0x5),
  R1(command: 0x6),
  L2(command: 0x7),
  R2(command: 0x8),
  SHARE(command: 0x9),
  OPTIONS(command: 0xa),
  L3(command: 0xb),
  R3(command: 0xc),
  HAT_UP(command: 0xd),
  HAT_DOWN(command: 0xe),
  HAT_LEFT(command: 0xf),
  HAT_RIGHT(command: 0x10),
  ;

  const ButtonType({required this.command});

  final int command;
}
