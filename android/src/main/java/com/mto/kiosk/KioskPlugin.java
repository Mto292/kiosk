package com.mto.kiosk;

import android.app.Activity;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;

import android.app.ActivityManager;
import android.content.Context;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;


public class KioskPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private MethodChannel channel;
    private Activity activity;

    @Override
    public void onAttachedToEngine(FlutterPlugin.FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "com.mto.kiosk/kiosk");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(FlutterPlugin.FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
    }

    @Override
    public void onDetachedFromActivity() {
        this.activity = null;
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "startKioskMode":
                startKioskMode(result);
                break;
            case "stopKioskMode":
                stopKioskMode(result);
                break;
            case "isInKioskMode":
                isInKioskMode(result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void startKioskMode(MethodChannel.Result result) {
        if (activity != null) {
            activity.findViewById(android.R.id.content).post(() -> {
                try {
                    activity.startLockTask();
                    result.success(true);
                } catch (Exception e) {
                    result.success(false);
                }
            });
        } else {
            result.success(false);
        }
    }

    private void stopKioskMode(MethodChannel.Result result) {
        try {
            if (activity != null) {
                activity.stopLockTask();
                result.success(true);
            } else {
                result.success(false);
            }
        } catch (Exception e) {
            result.success(false);
        }
    }


    private void isInKioskMode(MethodChannel.Result result) {
        try {
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
                ActivityManager service = (ActivityManager) activity.getSystemService(Context.ACTIVITY_SERVICE);
                if (service == null) {
                    result.success(null);
                } else {
                    int lockTaskModeState = 0;
                    lockTaskModeState = service.getLockTaskModeState();
                    final boolean isInKioskMode = lockTaskModeState == ActivityManager.LOCK_TASK_MODE_PINNED || lockTaskModeState == ActivityManager.LOCK_TASK_MODE_LOCKED;
                    result.success(isInKioskMode);
                }
            } else {
                result.success(null);
            }
        } catch (Exception e) {
            result.success(null);
        }
    }
}
