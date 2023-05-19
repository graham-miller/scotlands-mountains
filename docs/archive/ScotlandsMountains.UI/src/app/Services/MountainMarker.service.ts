import { formatNumber } from "@angular/common";
import { Injectable } from "@angular/core";
import { Router } from "@angular/router";
import * as L from 'leaflet';
import 'leaflet.markercluster';
import { Mountain } from "../Models/Mountain";
import { FormatHeightPipe } from "../Pipes/format-height.pipe";

@Injectable()
export class MountainMarkerService {

    constructor(
        private formatHeight: FormatHeightPipe,
        private router: Router
    ) { }

    public getMarker(mountain: Mountain, zIndex: number): L.Marker {
        const marker = L.marker([mountain.location.coordinates[1], mountain.location.coordinates[0]], { zIndexOffset: zIndex });
        marker.on('mouseover', e => this.showPopup(e, mountain));
        marker.on('mouseout', e => this.hidePopup(e));
        marker.on('click', e => this.togglePopup(e, mountain));

        return marker;
    }

    public createMarkerLayer(): L.LayerGroup<any> {
        return L.layerGroup();
    }
    
    public createMarkerClusterLayer(): L.MarkerClusterGroup {
        return L.markerClusterGroup({
        iconCreateFunction: () => {
          return L.divIcon({ html: '<div class="clustered-mountain-marker"><div>+<div></div>' });
        }
      });
    }

    private togglePopup(event: L.LeafletEvent, mountain: Mountain) {
        this.router.navigate([`/mountains/${mountain.id}`]);
    }

    private showPopup(event: L.LeafletEvent, mountain: Mountain) {
        event.target.bindPopup(this.getPopupText(mountain), {closeButton: false}).openPopup();
    }

    private hidePopup(event: L.LeafletEvent) {
        event.target.closePopup();
        event.target.unbindPopup();
    }

    private getPopupText(mountain: Mountain): string {
        const height = this.formatHeight.transform(mountain.height.metres);
        return `<span>${mountain.name}<br/>${height}</span>`
    }
}