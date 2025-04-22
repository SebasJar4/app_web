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
import { SvgUri } from "react-native-svg";
import { getNavs, rutes } from "../services/getNav";
import colors from "../assets/css/colors";

const getFullImageUrl = (imgPath) => {
  if (!imgPath) return null;
  const cleanPath = imgPath.startsWith("/") ? imgPath : "/" + imgPath;
  let fullUrl = rutes.host + "serverSvg.php?file=" + cleanPath;

  if (!/^https?:\/\//i.test(fullUrl)) {
    fullUrl = "http://" + fullUrl;
  }

  return fullUrl;
};

export default function NavList() {
  const navigation = useNavigation();
  const [navs, setNavs] = useState([]);
  const [collapsed, setCollapsed] = useState(true);
  const [widthAnim] = useState(new Animated.Value(60));

  useEffect(() => {
    (async () => {
      const data = await getNavs();
      console.log("Datos recibidos en navs navList:", data);

      const navsWithUrl = data.map((item) => ({
        ...item,
        fullUrl: getFullImageUrl(item.imgs_url),
      }));

      setNavs(navsWithUrl);
    })();
  }, []);

  const toggleCollapse = () => {
    Animated.timing(widthAnim, {
      toValue: collapsed ? 200 : 60,
      duration: 500,
      useNativeDriver: false,
    }).start();
    setCollapsed(!collapsed);
  };

  return (
    <Animated.View style={[styles.sidebar, { width: widthAnim }]}>
      <TouchableOpacity onPress={toggleCollapse}>
        <Text style={styles.collapseButton}> {collapsed ? "⏩" : "⏪"} </Text>
      </TouchableOpacity>

      <TouchableOpacity onPress={() => navigation.navigate("Home")}>
        <View style={styles.iconContainer}>
          <Image
            source={require("../assets/your_place_safed.png")}
            style={[styles.icon, collapsed && styles.iconCollapsed]}
            resizeMode="contain"
          />
        </View>
      </TouchableOpacity>

      {!collapsed && <Text style={styles.header}>Menú</Text>}

      <ScrollView contentContainerStyle={styles.menuContainer}>
        {navs.map((item) => {
          const imageUrl = item.fullUrl;
          const isSvg = imageUrl && imageUrl.endsWith(".svg");

          return (
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
                {imageUrl && isSvg ? (
                  <SvgUri
                    width={collapsed ? 30 : 24}
                    height={collapsed ? 30 : 24}
                    uri={imageUrl}
                    onError={(err) => {
                      console.warn("Error al cargar SVG:", err);
                    }}
                  />
                ) : (
                  <Image
                    source={{ uri: imageUrl }}
                    style={{
                      width: collapsed ? 30 : 24,
                      height: collapsed ? 30 : 24,
                      marginRight: 10,
                    }}
                    onError={(err) => {
                      console.warn("Error al cargar imagen:", err.nativeEvent);
                    }}
                  />
                )}

                {!collapsed && (
                  <Text style={styles.itemText}>{item.nav_name}</Text>
                )}
              </View>
            </TouchableOpacity>
          );
        })}
      </ScrollView>
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  sidebar: {
    backgroundColor: colors[900],
    justifyContent: "flex-start",
    paddingVertical: 20,
    alignItems: "center",
    height: "100%",
  },

  collapseButton: {
    fontSize: 30,
    color: colors[50],
    padding: 16,
    alignSelf: "flex-end",
    resizeMode: "contain",
  },

  iconContainer: {
    alignItems: "center",
    width: 100,
    marginBottom: 20,
  },

  icon: {
    width: 100,
    height: 100,
    resizeMode: "contain",
  },

  iconCollapsed: {
    width: 40,
    height: 40,
    resizeMode: "contain",
  },

  header: {
    fontSize: 20,
    fontWeight: "bold",
    color: colors[100],
  },

  menuContainer: {
    paddingBottom: 20,
    width: "100%",
    flex: 15,
  },

  menuItem: {
    marginBottom: 16,
    width: "100%",
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },

  navRow: {
    flexDirection: "row",
    alignItems: "center",
  },

  itemText: {
    fontSize: 16,
    color: colors[100],
    marginLeft: 10,
  },
});
