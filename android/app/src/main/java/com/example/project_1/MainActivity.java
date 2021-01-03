package com.example.SolveShare;

import android.os.Bundle;
//import io.flutter.embedding.FlutterApplication;
import io.flutter.plugins.GeneratedPluginRegistrant;



import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

//public class MainActivity extends FlutterActivity {
//
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        GeneratedPluginRegistrant.registerWith(this);
//    }
//}

//class MainActivity: FlutterActivity() {
//override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//     super.configureFlutterEngine(flutterEngine);
//     GeneratedPluginRegistrant.registerWith(flutterEngine);
//}
//}

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity;

public class MainActivity extends FlutterFragmentActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}