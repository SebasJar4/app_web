import React, { useEffect } from "react";
import { View, Text, StyleSheet } from "react-native";
import { colors } from "../assets/css/colors";
import CarruselComponent from "../utils/Carrusel_home"; 

export default function Home() {

  return (
    <View style={styles.container}>
      <View style={ styles.container_title }>
        <Text style = { [ styles.title, styles.Text ] }> Bienvenido a la página principal </Text>
      </View>
      <View style={styles.container_carousel}>
        <CarruselComponent />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: colors[700],
    display: "flex"
    ,flexDirection: "colums"
  },

  container_title: {
     width: "100%"
    ,backgroundColor: "#0003"
    ,height: "auto"

  },
  
  title: {
    fontSize: 24,
  },
  
  Text: {
    color: colors[200],
    backgroundColor: colors[950] + "dd",
    alignSelf: "center",
    padding: 10,
    borderRadius: 10,
    fontWeight: "bold",
    textShadow: `${colors[800]} 1px 1px 2px`
  },

  container_carousel: {
     display: "flex"
     ,flexDirection: "column"
    ,backgroundColor: "#000"
    ,marginTop: "2rem"
  }
});
