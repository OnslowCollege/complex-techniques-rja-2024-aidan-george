import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet],
  styleUrl: './app.component.scss',
  template: `
    <h1>Hello world!</h1>
  `
})
export class AppComponent {
  title = 'app';
}
