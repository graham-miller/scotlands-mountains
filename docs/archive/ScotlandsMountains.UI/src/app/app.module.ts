import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { HttpClientModule } from '@angular/common/http';
import { HomeComponent } from './Components/home/home.component';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatTabsModule } from '@angular/material/tabs';
import { MatToolbarModule } from '@angular/material/toolbar';
import { HeaderComponent } from './Components/header/header.component';
import { FooterComponent } from './Components/footer/footer.component';
import { LegalComponent } from './Components/legal/legal.component';
import { TableComponent } from './Components/table/table.component';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSortModule } from '@angular/material/sort';
import { MapComponent } from './Components/map/map.component';
import { MapService } from './Services/Map.service';
import { MountainMarkerService } from './Services/MountainMarker.service';
import { ClassificationsComponent } from './Components/classifications/classifications.component';
import { PageNotFoundComponent } from './Components/page-not-found/page-not-found.component';
import { GettyComponent } from './Components/getty/getty.component';
import { MatOptionModule } from '@angular/material/core';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MountainComponent } from './Components/mountain/mountain.component';
import { LoadingComponent } from './Components/loading/loading.component';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { FormatHeightPipe } from './Pipes/format-height.pipe';
import { FormsModule } from '@angular/forms';
import { SearchComponent } from './Components/search/search.component';
import { AutofocusDirective } from './Directives/autofocus.directive';
import { HighlightPipe } from './Pipes/highlight.pipe';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    HeaderComponent,
    FooterComponent,
    LegalComponent,
    MapComponent,
    ClassificationsComponent,
    TableComponent,
    PageNotFoundComponent,
    GettyComponent,
    MountainComponent,
    LoadingComponent,
    FormatHeightPipe,
    SearchComponent,
    AutofocusDirective,
    HighlightPipe
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    FormsModule,
    HttpClientModule,
    MatButtonModule,
    MatIconModule,
    MatInputModule,
    MatSelectModule,
    MatTabsModule,
    MatToolbarModule,
    MatTableModule,
    MatPaginatorModule,
    MatSortModule,
    MatProgressSpinnerModule,
    MatOptionModule,
    MatAutocompleteModule
  ],
  providers: [
    FormatHeightPipe,
    MapService,
    MountainMarkerService
  ],
  bootstrap: [AppComponent],
})
export class AppModule { }
