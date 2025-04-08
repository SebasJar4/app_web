import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Animated,
} from "react-native";
import { useNavigation } from "@react-navigation/native";
import { getNavs } from "../services/getNav";

export default function NavList() {
  const navigation = useNavigation();
  const [navs, setNavs] = useState([]);
  const [collapsed, setCollapsed] = useState(false);
  const [widthAnim] = useState(new Animated.Value(200)); // animación del ancho

  useEffect(() => {
    (async () => {
      const data = await getNavs();
      setNavs(data);
    })();
  }, []);

  const toggleCollapse = () => {
    Animated.timing(widthAnim, {
      toValue: collapsed ? 200 : 60,
      duration: 300,
      useNativeDriver: false,
    }).start();
    setCollapsed(!collapsed);
  };

  return (
    <Animated.View style={[styles.sidebar, { width: widthAnim }]}>
      <TouchableOpacity onPress={toggleCollapse}>
        <Text style={styles.collapseButton}>
          {collapsed ? "⏩" : "⏪"}
        </Text>
      </TouchableOpacity>

      {!collapsed && <Text style={styles.header}>Menú</Text>}

      {navs.map((item) => (
        <TouchableOpacity
          key={item.nav_id}
          onPress={() => {
            if (typeof item.url === "string") {
              navigation.navigate(item.url);
            } else if (typeof item.url === "object" && item.url.name) {
              navigation.navigate(item.url);
            } else {
              console.warn("Ruta inválida:", item.url);
            }
          }}
        >
          <Text style={styles.item}>
            🔹 {collapsed ? "" : item.nav_name}
          </Text>
        </TouchableOpacity>
      ))}
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  sidebar: {
    backgroundColor: "#2c3e50",
    padding: 10,
    justifyContent: "flex-start",
  },
  collapseButton: {
    fontSize: 18,
    color: "#ecf0f1",
    marginBottom: 10,
    textAlign: "right",
  },
  header: {
    fontSize: 20,
    fontWeight: "bold",
    color: "#ecf0f1",
    marginBottom: 20,
  },
  item: {
    fontSize: 18,
    color: "#ecf0f1",
    marginBottom: 12,
  },
});
