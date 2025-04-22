import { StyleSheet } from "react-native"
import colors  from "./css/colors";

export const basicStyles = StyleSheet.create({
  view: {
    flex: 1, // ocupa todo el espacio disponible
    backgroundColor: colors[800],
    paddingVertical: 10
  },
});
