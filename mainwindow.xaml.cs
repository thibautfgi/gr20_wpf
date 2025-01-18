using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Shapes;
using System.Xml.Linq;
using GMap.NET;
using GMap.NET.MapProviders;
using GMap.NET.WindowsPresentation;
using MySql.Data.MySqlClient;

namespace GpxMapViewer
{
    public partial class MainWindow : Window
    {
        private ObservableCollection<Etape> etapes;
        private Dictionary<string, string> etapeFileDictionary; // Associe le nom de l'étape au fichier GPX

        public MainWindow()
        {
            InitializeComponent();

            // Initialisation de la carte
            MapControl.MapProvider = GMapProviders.OpenStreetMap;
            MapControl.MinZoom = 2;
            MapControl.MaxZoom = 17;
            MapControl.Zoom = 10;
            MapControl.Position = new PointLatLng(42.1110, 9.0250); // Centré sur la Corse
            MapControl.ShowCenter = false;
            MapControl.CanDragMap = true;
            MapControl.MouseWheelZoomType = MouseWheelZoomType.MousePositionWithoutCenter;
            MapControl.DragButton = System.Windows.Input.MouseButton.Left;

            etapes = new ObservableCollection<Etape>();
            EtapeListBox.ItemsSource = etapes; // Lier les étapes à une liste affichée

            etapeFileDictionary = new Dictionary<string, string>();
            SqlEtape(); // Chargement des étapes depuis la base de données
        }

        // Garde la fonction LoadGpxFile inchangée
        private void LoadGpxFile(string filePath)
        {
            string road = @"C:\Users\tibof\Desktop\Projet\Project B3\WpfApp1\Assets\map\";

            try
            {
                string fullPath = System.IO.Path.Combine(road, filePath);

                XDocument gpxDoc = XDocument.Load(fullPath);
                SolidColorBrush baseColors;

                var waypoints = gpxDoc.Descendants()
                    .Where(x => x.Name.LocalName == "trkpt")
                    .Select(x => new
                    {
                        Latitude = double.Parse(x.Attribute("lat")?.Value ?? "0", CultureInfo.InvariantCulture),
                        Longitude = double.Parse(x.Attribute("lon")?.Value ?? "0", CultureInfo.InvariantCulture),
                        Elevation = x.Descendants().First().Value != null ? double.Parse(x.Descendants().First().Value ?? "0", CultureInfo.InvariantCulture) : 666
                    });

                if (!waypoints.Any())
                {
                    MessageBox.Show("Aucun point trouvé dans le fichier GPX. Vérifiez la structure du fichier.");
                    return;
                }

                foreach (var waypoint in waypoints)
                {
                    if (waypoint.Elevation >= 2000)
                    {
                        baseColors = Brushes.Black;
                    }
                    else if (waypoint.Elevation >= 1500 && waypoint.Elevation < 2000)
                    {
                        baseColors = Brushes.Red;
                    }
                    else if (waypoint.Elevation >= 1000 && waypoint.Elevation < 1500)
                    {
                        baseColors = Brushes.Orange;
                    }
                    else if (waypoint.Elevation >= 500 && waypoint.Elevation < 1000)
                    {
                        baseColors = Brushes.Yellow;
                    }
                    else
                    {
                        baseColors = Brushes.Green;
                    }

                    var marker = new GMapMarker(new PointLatLng(waypoint.Latitude, waypoint.Longitude))
                    {
                        Shape = new Ellipse
                        {
                            Width = 10,
                            Height = 10,
                            Stroke = baseColors,
                            StrokeThickness = 2,
                            Fill = baseColors
                        }
                    };
                    MapControl.Markers.Add(marker);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erreur lors du chargement du fichier GPX : " + ex.Message);
            }
        }

        // ferme l'app
        private void quit(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }


        // reviens au menue principal
        private void retourListEtape(object sender, RoutedEventArgs e)
        {
            ResetMap(sender, e);
            Panel2.Visibility = Visibility.Collapsed;
            Panel3.Visibility = Visibility.Visible;
            Panel4.Visibility = Visibility.Collapsed;
        }

     


        // génère le gpx de l'etape clicked, passe sur le details de l'etape
        private void ListBoxItem_Click(object sender, RoutedEventArgs e)
        {

            Panel2.Visibility = Visibility.Visible;
            Panel3.Visibility = Visibility.Collapsed;
            Panel4.Visibility = Visibility.Visible;  

            ResetMap(sender, e);

            var clickedItem = sender as StackPanel;
            if (clickedItem != null)
            {

                var selectedEtape = clickedItem.DataContext as Etape;
                if (selectedEtape != null)
                {
   
                    Panel4.DataContext = selectedEtape;

                    // Charger le fichier GPX associé à l'étape
                    if (etapeFileDictionary.TryGetValue(selectedEtape.EtapeName, out string fileName))
                    {
                        LoadGpxFile(fileName);
                    }
                    else
                    {
                        MessageBox.Show("Fichier GPX introuvable pour cette étape.");
                    }
                }
            }
        }




        // Fonction pour récupérer les étapes depuis la base de données
        private void SqlEtape()
        {
            const string M_str_sqlcon = "Server=127.0.0.1;User ID=root;Password=azerty;Database=b3_mj_v2;Allow User Variables=true";

            using (var mySqlCn = new MySqlConnection(M_str_sqlcon))
            {
                using (var mySqlCmd = new MySqlCommand("SELECT * FROM etapes", mySqlCn))
                {
                    mySqlCn.Open();
                    using (MySqlDataReader mySqlReader = mySqlCmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (mySqlReader.Read())
                        {
                            var etape = new Etape
                            {
                                FileName = mySqlReader["Etape_FileName"].ToString(),
                                EtapeName = mySqlReader["Etape_Name"].ToString(),
                                Description = mySqlReader["Etape_Description"].ToString(),
                                Distance = mySqlReader["Etape_Km"].ToString(),
                                Positif = mySqlReader["Etape_Positif"].ToString(),
                                Negatif = mySqlReader["Etape_Negatif"].ToString(),
                                Duree = mySqlReader["Etape_Duree"].ToString(),
                                EtapeImg = mySqlReader["Etape_Img"].ToString()
                            };

                            etapes.Add(etape);
                            etapeFileDictionary[etape.EtapeName] = etape.FileName;
                        }
                    }
                }
            }
        }

        // Réinitialise la carte en supprimant tous les marqueurs
        private void ResetMap(object sender, RoutedEventArgs e)
        {
            MapControl.Markers.Clear();
        }

        // Classe pour représenter une étape
        public class Etape
        {
            
                

            public string EtapeName { get; set; }

            public string FileName { get; set; }
            public string Description { get; set; }
            public string Distance { get; set; }
            public string Positif { get; set; }
            public string Negatif { get; set; }
            public string Duree { get; set; }
            public string EtapeImg { get; set; }
        }
    }
}
