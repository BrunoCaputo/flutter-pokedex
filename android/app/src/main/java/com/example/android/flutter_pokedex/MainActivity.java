package com.example.android.flutter_pokedex;

import android.annotation.TargetApi;
import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.media.MediaPlayer;
import android.os.Build;
import android.os.Bundle;
import android.os.Vibrator;
import android.util.Log;

import androidx.annotation.NonNull;

import java.io.IOException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "pokemon_sound_channel";
    private SensorManager sensorManager;
    private MediaPlayer mediaPlayer;
    private long lastShakeTime = 0;
    private boolean isListeningForShake = false;
    private String currentPokemonCryUrl;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("startListeningForShake")) {
                        currentPokemonCryUrl = call.argument("pokemonCryUrl");
                        startListeningForShake();
                        result.success(null);
                    } else if (call.method.equals("stopListeningForShake")) {
                        stopListeningForShake();
                        result.success(null);
                    } else {
                        result.notImplemented();
                    }
                }
        );
    }

    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    private void startListeningForShake() {
        if (!isListeningForShake) {
            isListeningForShake = true;
            Sensor accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
            sensorManager.registerListener(sensorListener, accelerometer, SensorManager.SENSOR_DELAY_NORMAL);
        }
    }

    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    private void stopListeningForShake() {
        if (isListeningForShake) {
            isListeningForShake = false;
            sensorManager.unregisterListener(sensorListener);
        }
    }

    private final SensorEventListener sensorListener = new SensorEventListener() {
        @TargetApi(Build.VERSION_CODES.CUPCAKE)
        @Override
        public void onSensorChanged(SensorEvent event) {
            float x = event.values[0];
            float y = event.values[1];
            float z = event.values[2];

            float gX = x / SensorManager.GRAVITY_EARTH;
            float gY = y / SensorManager.GRAVITY_EARTH;
            float gZ = z / SensorManager.GRAVITY_EARTH;

            double gForce = Math.sqrt(gX * gX + gY * gY + gZ * gZ);

            if (gForce > 2.7) {
                long now = System.currentTimeMillis();
                if (now - lastShakeTime > 1000) {
                    lastShakeTime = now;
                    playPokemonCry(currentPokemonCryUrl);
                    Vibrator v = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
                    if (v != null) {
                        v.vibrate(300);
                    }
                }
            }
        }

        @Override
        public void onAccuracyChanged(Sensor sensor, int accuracy) {
        }
    };

    private void playPokemonCry(String url) {
        if (url != null) {
            if (mediaPlayer != null) {
                mediaPlayer.release();
                mediaPlayer = null;
            }
            mediaPlayer = new MediaPlayer();
            try {
                mediaPlayer.setDataSource(url);
                mediaPlayer.prepare();
                mediaPlayer.start();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
