# rn-qr-barcode-image-scan

react native library for scanning qrcode/barcode from image

## Installation

```sh
npm install rn-qr-barcode-image-scan
```

or

```sh
yarn add rn-qr-barcode-image-scan
```

## Usage

```js
import { scanFromPath } from 'rn-qr-barcode-image-scan';
import {
  launchImageLibrary,
  type ImageLibraryOptions,
} from 'react-native-image-picker';

// ...

const option: ImageLibraryOptions = {
  mediaType: 'photo',
};
const result = await launchImageLibrary(option);
const uri = result?.assets?.[0]?.uri;
if (!uri) {
  return;
}
//codes: string[]
const codes = await scanFromPath(uri);
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
