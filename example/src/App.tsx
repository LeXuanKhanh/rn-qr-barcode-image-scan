import { useState, useCallback } from 'react';
import { StyleSheet, View, Text, Button } from 'react-native';
import { scanFromPath } from 'rn-qr-barcode-image-scan';
import {
  launchImageLibrary,
  type ImageLibraryOptions,
} from 'react-native-image-picker';

export default function App() {
  const [qrCodes, setQrCodes] = useState<string[]>([]);

  const onPress = useCallback(async () => {
    const option: ImageLibraryOptions = {
      mediaType: 'photo',
    };
    const result = await launchImageLibrary(option);
    const uri = result?.assets?.[0]?.uri;
    if (!uri) {
      return;
    }

    const codes = await scanFromPath(uri);
    setQrCodes(codes);
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {qrCodes}</Text>
      <Button onPress={onPress} title="Open Picker" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
