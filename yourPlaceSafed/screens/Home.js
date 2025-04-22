import React from "react";
import { View, Text, StyleSheet } from "react-native";
// Paleta de colores:
import colors from "../assets/css/colors";

// import ServiceCarousel from "../utils/Carrusel_home";



export default function Home() {
  return (
    <View style={styles.container}>
      <Text style={[styles.title , styles.Text]}>Bienvenido a la página principal</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { 
    flex: 1
   ,padding: 20 
   ,backgroundColor: colors[700]
   ,color: 100
  }
  ,title: { fontSize: 24 }
  ,Text:{
    color:colors[200]
   ,backgroundColor: (colors[950] + "dd")
   ,alignSelf:"center"
   ,padding: 10
   ,paddingTop: 10
   ,borderRadius: 10
   ,fontWeight: "bold"
   ,textShadowColor: colors[800]
   ,textShadowOffset: { width: 1, height: 1 }
   ,textShadowRadius: 2,
  }
});
