import React from "react";
import { View, Text, StyleSheet } from "react-native";
// Paleta de colores:
import { colors } from "../assets/css/colors";
export default function Home() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Bienvenido a la página principal</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { 
    flex: 1
   ,padding: 20 
   ,backgroundColor: colors[500]
  }
  ,title: { fontSize: 24 }
  ,
});
