import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { KeyboardComponent } from './keyboard/keyboard.component';
import { DisplayComponent } from './display/display.component';
@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, KeyboardComponent, DisplayComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'app';
}
