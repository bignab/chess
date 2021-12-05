# frozen_string_literal: true

# Colorization class for strings.
class String
  def black;          "\e[30m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods
  def red;            "\e[31m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def green;          "\e[32m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def brown;          "\e[33m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def blue;           "\e[34m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def magenta;        "\e[35m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def cyan;           "\e[36m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def gray;           "\e[37m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def bg_black;       "\e[40m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def bg_red;         "\e[41m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def bg_green;       "\e[42m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def bg_brown;       "\e[43m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def bg_blue;        "\e[44m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def bg_magenta;     "\e[45m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def bg_cyan;        "\e[46m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def bg_gray;        "\e[47m#{self}\e[0m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def bold;           "\e[1m#{self}\e[22m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def italic;         "\e[3m#{self}\e[23m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def underline;      "\e[4m#{self}\e[24m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def blink;          "\e[5m#{self}\e[25m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
  def reverse_color;  "\e[7m#{self}\e[27m" end # rubocop:disable Style/SingleLineMethods, Layout/EmptyLineBetweenDefs
end
