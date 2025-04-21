import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Animated,
  Image,
  ScrollView,
} from "react-native";
import { useNavigation } from "@react-navigation/native";
import { getNavs } from "../services/getNav";
import icon from "../assets/your_place_safed.png"; // ícono principal
import { colors } from "../assets/css/colors";clear

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

  const getFullImageUrl = (imgPath) => {
    if (!imgPath) return null;
    return `http://localhost:8081${imgPath}.svg`;
  };

  return (
    <Animated.View style={[styles.sidebar, { width: widthAnim }]}>
      <TouchableOpacity onPress={toggleCollapse}>
        <Text style={styles.collapseButton}>{collapsed ? "⏩" : "⏪"}</Text>
      </TouchableOpacity>

      <TouchableOpacity onPress={() => navigation.navigate("Home")}>
        <View style={styles.iconContainer}>
          <Image
            source={icon}
            style={[styles.icon, collapsed && styles.iconCollapsed]}
            resizeMode="contain"
          />
        </View>
      </TouchableOpacity>

      {!collapsed && <Text style={styles.header}>Menú</Text>}

      <ScrollView contentContainerStyle={styles.menuContainer}>
        {navs.map((item) => (
          <TouchableOpacity
            key={item.nav_id}
            style={styles.menuItem}
            onPress={() => {
              if (item.url) {
                navigation.navigate(item.url);
              } else {
                console.warn("Ruta inválida:", item.url);
              }
            }}
          >
            <View style={styles.navRow}>
              {item.imgs_url && (
                <Image
                  source={{ uri: getFullImageUrl(item.imgs_url) }}
                  style={collapsed ? styles.menuIconCollapsed : styles.menuIcon}
                  resizeMode="contain"
                />
              )}
              {!collapsed && (
                <Text style={styles.itemText}>{item.nav_name}</Text>
              )}
            </View>
          </TouchableOpacity>
        ))}
      </ScrollView>
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  sidebar: {
    backgroundColor: "#2c3e50",
    padding: 10,
    justifyContent: "flex-start",
    alignItems: "center",
    height: "100%",
  },
  collapseButton: {
    fontSize: 18,
    color: "#ecf0f1",
    marginBottom: 10,
    alignSelf: "flex-end",
  },
  iconContainer: {
    alignItems: "center",
    marginBottom: 10,
  },
  icon: {
    width: 100,
    height: 100,
  },
  iconCollapsed: {
    width: 40,
    height: 40,
  },
  header: {
    fontSize: 20,
    fontWeight: "bold",
    color: "#ecf0f1",
    marginBottom: 10,
  },
  menuContainer: {
    paddingBottom: 20,
    width: "100%",
  },
  menuItem: {
    marginBottom: 16,
    width: "100%",
  },
  navRow: {
    flexDirection: "row",
    alignItems: "center",
  },
  menuIcon: {
    width: 24,
    height: 24,
    marginRight: 10,
  },
  menuIconCollapsed: {
    width: 30,
    height: 30,
    alignSelf: "center",
  },
  itemText: {
    fontSize: 16,
    color: "#ecf0f1",
  },
});
