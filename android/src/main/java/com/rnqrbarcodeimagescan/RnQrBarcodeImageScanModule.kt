package com.rnqrbarcodeimagescan

import android.graphics.BitmapFactory
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.google.mlkit.vision.barcode.BarcodeScannerOptions
import com.google.mlkit.vision.barcode.BarcodeScanning
import com.google.mlkit.vision.common.InputImage
import java.io.File

class RnQrBarcodeImageScanModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return NAME
  }

  @ReactMethod
  fun scanFromPath(path: String, promise: Promise) {
    val options = BarcodeScannerOptions.Builder()
      .build()
    val rPath = path.replace("file:", "")
    val imgFile = File(rPath)
    if (!imgFile.exists()) {
      promise.reject("", "cannot get image from path: $path")
      return
    }

    val bitmap = BitmapFactory.decodeFile(imgFile.absolutePath)
    val image = InputImage.fromBitmap(bitmap, 0)
    val scanner = BarcodeScanning.getClient(options)
    scanner.process(image)
      .addOnSuccessListener { barcodes ->
        val codes = barcodes.map { it.displayValue }
        val arr = Arguments.fromList(codes)
        promise.resolve(arr)
      }
      .addOnFailureListener {
        promise.reject("", it.localizedMessage, it)
      }

  }

  companion object {
    const val NAME = "RnQrBarcodeImageScan"
  }
}
