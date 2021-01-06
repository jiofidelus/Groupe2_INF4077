package com.info4077.group2;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;

public class MainActivity extends AppCompatActivity {

  private static final int MY_CAMERA_PERMISSION_CODE = 1001;
  private ImageView nimageView ;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);

    nimageView = findViewById(R.id.imageView);
    final Button button = (Button) findViewById(R.id.buttonCamera);


    button.setOnClickListener(new View.OnClickListener()

    {
      @RequiresApi(api = Build.VERSION_CODES.M)
      public void onClick(View v){


        if (checkSelfPermission(Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
          requestPermissions(new String[]{Manifest.permission.CAMERA}, MY_CAMERA_PERMISSION_CODE);

          Intent intent =  new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
          startActivityForResult(intent, MY_CAMERA_PERMISSION_CODE);
        }

        Intent intent =  new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        startActivityForResult(intent, MY_CAMERA_PERMISSION_CODE);

      }
    });
  }

  @Override
  protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
    super.onActivityResult(requestCode, resultCode, data);

    if (requestCode == MY_CAMERA_PERMISSION_CODE){
      if (resultCode == RESULT_OK){
        Bitmap bitmap = (Bitmap) data.getExtras().get("data");
        nimageView.setImageBitmap(bitmap);
      }
    }
  }
}
