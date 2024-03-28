class DecoderEnum {
  static K getData<T, K extends Enum>(T key,
      {required Map<T, K> decoder, K? defaultValue}) {
    if (decoder.containsKey(key)) {
      return decoder[key]!;
    } else {
      if (defaultValue != null) return defaultValue;
      throw const FormatException();
    }
  }
}
