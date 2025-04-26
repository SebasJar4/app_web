// DefaultScreen.js
import React from "react";
import { View, Text } from "react-native";

export default function Default({ route }) {
  const { title } = route.params;

  return (
    <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
      <Text style={{ fontSize: 24 }}>{title}</Text>
      {/* Puedes hacer más lógica según el título o el nombre de ruta */}
    </View>
  );
}
