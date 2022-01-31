mixin JsonConverter<T, D> {
  T fromJson(D json);

  D toJson(T object);
}
